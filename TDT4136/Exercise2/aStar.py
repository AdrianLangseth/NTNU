import queue
from Map import Map_Obj
import numpy as np

__author__ = "Adrian Langseth"




goal = []

def best_first_search(start, end):
    goal = end

    # CLOSED ← ∅; OPEN ← ∅
    closed = {}
    open = []

    # Generate the initial node, n0, for the start state
    startNode = Node(None, start)

    # g(n0) ← 0; Calculate h(n0)
    startNode.g = 0
    startNode.h = manhattan(start, end)

    # f(n0) ← g(n0) + h(n0);
    startNode.f = startNode.g + startNode.h

    # Push n0 onto OPEN.
    open.append(startNode)

    while True:
    #     • If OPEN = ∅ return FAIL
        if len(open) == 0:
            return None, False

    #     • X ← pop(OPEN)
        node = open.pop(0)

        mp.set_cell_value(node.position, 3)

    #     • push(X,CLOSED)
        closed[tuple(node.position)] = node

    #     • If X is a solution, return (X, SUCCEED)
        if node.position == end:
            mp.show_map()
            return node, True
    #     • SUCC ← generate-all-successors(X)

        node.get_children(target=end)
    #     • For each S ∈ SUCC :
        for successor in node.children:
            if successor in open:
                # Find noden
                for idx in range(len(open)):
                    if successor == open[idx]:
                        successor = open[idx]
                        break

            if (successor not in open) and (tuple(successor.position) not in closed.keys()):
                attach_and_eval(successor, node, end)
                open.append(successor)
                open.sort(key=lambda x: x.f)

            if tuple(successor.position) in closed.keys() and (successor.g < closed[tuple(successor.position)].g):
                attach_and_eval(successor, node, end)
                if tuple(successor.position) in closed.keys():
                    propagate_path_improvements(successor)

    #       – If node S* has previously been created, and if state(S*) = state(S), then S ← S*.

            #if tuple(successor.position) in closed.keys():
                #successor.f

    #         – push(S,kids(X))
    #         – If not(S ∈ OPEN) and not(S ∈ CLOSED) do:
    #             ∗ attach-and-eval(S,X)
    #             ∗ insert(S,OPEN) ;; OPEN is sorted by ascending f value.
    #         – else if g(X) + arc-cost(X,S) < g(S) then (found cheaper path to S):
    #             ∗ attach-and-eval(S,X)
    #             ∗ If S ∈ CLOSED then propagate-path-improvements(S)


class Node:
    def __init__(self, parent = None, position = None):
        self.parent = parent
        self.position = position

        self.f = 0
        self.g = 0
        self.h = 0

        self.children = []

    def __eq__(self, other):
        return self.position == other.position

    def get_children(self, target):
        kidpos = []
        if (mp.get_cell_value([self.position[0] + 1, self.position[1]])) != -1:
            kidpos.append([self.position[0] + 1, self.position[1]])
        if (mp.get_cell_value([self.position[0] - 1, self.position[1]])) != -1:
            kidpos.append([self.position[0] - 1, self.position[1]])
        if (mp.get_cell_value([self.position[0], self.position[1] + 1])) != -1:
            kidpos.append([self.position[0], self.position[1] + 1])
        if (mp.get_cell_value([self.position[0], self.position[1] - 1])) != -1:
            kidpos.append([self.position[0], self.position[1] - 1])

        for kid in kidpos:
            if mp.get_cell_value(kid) == -1:
                print(f"Fuck. Trampet ut i veggen på {kid} når expanded {self.position}")

            child = Node(self, kid)
            child.g = self.g + mp.get_cell_value(kid)
            child.h = manhattan(kid, target)
            child.f = child.g + child.h
            self.children.append(child)


def manhattan(start: list, end: list):
    return np.abs(start[0] - end[0]) + np.abs(start[1] - end[1])


def attach_and_eval(child: Node, parent: Node, target: list):
    child.parent = parent
    child.g = parent.g + mp.get_cell_value(child.position)
    child.h = manhattan(child.position, target)
    child.f = child.g + child.h


def propagate_path_improvements(parent):
    for kid in parent.children:
        if (parent.g + mp.get_cell_value(kid.position) < kid.g):
            kid.parent = parent
            kid.g = parent.g + mp.get_cell_value(kid.position)
            kid.f = kid.g + kid.h
            propagate_path_improvements(kid)


mp = Map_Obj(task=4)

result_node, succ = best_first_search(mp.start_pos, mp.goal_pos)
if succ is True:
    while result_node is not mp.start_pos and result_node is not None:
        print(result_node.position)
        mp.set_cell_value(result_node.position, " G ")
        result_node = result_node.parent
    mp.show_map()