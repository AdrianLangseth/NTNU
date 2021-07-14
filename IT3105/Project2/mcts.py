import numpy as np
from collections import defaultdict, deque
from hex_manager import *
import random
from typing import Callable
from time import perf_counter

from rl_agent import *


class Node:
    def __init__(self, state, parent, action=None):
        """
        Must haves:
        - Node value Q
        - (Incoming) Edge Value
        - Edge visit counts N
        -
        """
        self.parent = parent
        self.children = {}  # {edge: Node}
        self.edge_incoming = action

        self.state = state

        self.N = 0  # Node Visits
        self.E = defaultdict(int)  # Edge Visits: {Edge: #visit}
        self.Q = defaultdict(int)  # Q value of self and edge: {Edge: Q-Value}

    def add_child(self, child: "Node"):
        self.children[child.edge_incoming] = child

    def uct_value(self, edge, exploration_factor):
        if not self.E[edge]:
            return exploration_factor*np.sqrt(np.log(self.N+1) / (1 + self.E[edge]))
        return self.Q[edge]/self.E[edge] + exploration_factor*np.sqrt(np.log(self.N) / (1 + self.E[edge]))

    def get_depth(self) -> int:
        if self.parent is None:
            return 0
        return self.parent.get_depth() + 1


class MCTS:
    def __init__(self, env: GameManager, root_node, e_greedy):
        self.e_greedy = e_greedy
        self.env = env
        self.root = root_node
        self.edge_deque = deque()

    def search_games(self, max_amount:int, max_time:float, default_policy:Callable, exploration_factor:float=1.):
        t = perf_counter()
        for i in range(max_amount):
            if perf_counter() - t > max_time:
                break
            leaf_node = self.tree_search(exploration_factor=exploration_factor)
            expanded = self.node_expansion(leaf_node)
            winner, selected_new_leaf = self.leaf_eval(leaf_node=leaf_node,
                                                       default_policy=default_policy,
                                                       expanded=expanded)
            self.backprop(leaf=selected_new_leaf, reward_dict=winner)

        # print(i)
        # print(self.root.state[1:].reshape((4,4)))
        # print(f"Q: {self.root.Q}")
        # print(f"E: {self.root.E}")

    def tree_search(self, exploration_factor=2.):
        """
        Traversing the tree from the root to a leaf node by using the tree policy
        :return: True
        """
        node = self.root
        while node.children:  # Until we reach a node with no children
            best_known_action = max(node.children,
                                    key=lambda action: node.uct_value(action, exploration_factor))
            # self.env.next_state(node.state, best_known_action)
            node = node.children[best_known_action]
            self.edge_deque.append(best_known_action)
        return node

    def node_expansion(self, node: Node) -> bool:
        # Expand given node
        if self.env.terminal(node.state):
            return False

        edges = self.env.legal_actions(node.state)
        random.shuffle(edges)
        expanded = False

        for edge in edges:
            if edge not in node.children.keys():
                next_state = self.env.next_state(node.state, edge)
                next_node = Node(next_state, node, edge)
                node.add_child(next_node)
                expanded = True
        return expanded

    def leaf_eval(self, leaf_node: Node, default_policy: Callable, expanded):
        if self.env.terminal(leaf_node.state):
            return self.env.reward_dict(leaf_node.state), leaf_node

        if expanded:
            edge = random.choice(list(leaf_node.children))
            # edge = default_policy(leaf_node.state)
            leaf_node = leaf_node.children[edge]
            self.edge_deque.append(edge)

        roll_state = leaf_node.state

        while not self.env.terminal(roll_state):
            if np.random.rand() < self.e_greedy:
                action = np.random.choice(self.env.legal_actions(roll_state))
            else:
                action = default_policy(roll_state)
            roll_state = self.env.next_state(roll_state, action)

        return self.env.reward_dict(roll_state), leaf_node

    def backprop(self, leaf: Node, reward_dict: dict):
        leaf.N += 1
        tracked_node = leaf.parent

        while True:
            action = self.edge_deque.pop()

            tracked_node.E[action] += 1
            tracked_node.N += 1
            tracked_node.Q[action] += reward_dict[self.env.get_player(tracked_node.state)]

            if tracked_node.parent is None:  # tracked node has reached root and we have performed the rating ops
                break

            tracked_node = tracked_node.parent

        assert tracked_node == self.root
        return True

    def set_root(self, action):
        self.root = self.root.children[action]
        self.root.parent = None

    def get_root_edge_visits(self):
        return self.root.state, self.root.E


if __name__ == '__main__':
    gm = GameManager(size=3)
    mcts = MCTS(gm, Node(gm.get_start_state(), None))
    node = mcts.tree_search()
