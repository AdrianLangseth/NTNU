import numpy as np
from collections import deque
import networkx as nx
from matplotlib import pyplot as plt
from os import mkdir

# The assignment suggests two different representations of the state: one for neighbor relationships for code to analyze
# states, and one for input for ANN. The HexGame.board is the one for the ANN, the unions kept for each player is used
# for board_state analysis.



# todo
# - remove assertions and self-implemented errors, as they will use time on unecessary shit. All else implemented correctly, they will never be necessary.
# - remove UnionFind, it was a good idea but its time to kill it.

class UnionFind:
    """
    An implementation of the Union-Find data-structure specific to Hex game winner determination.
    Will use (x,y) as grid point objects in the sets.
    Used the slides from a princeton lecture for guidance.
    Groups are defined by a single ID.
    """

    def __init__(self):
        """
        Will allways be initiated with an empty board
        """
        self.group_assignments = {}

    def find(self, coord, target):
        return self.get_parent(coord) is self.get_parent(target)

    def union(self, coord, target):
        # TODO: Right now, this just throws the top parent of the coord onto the targets top parent. Seems inefficient.
        cp = self.get_parent(coord)
        tp = self.get_parent(target)

        self.group_assignments[cp] = tp
        self.get_parent(coord)
        return True

    def get_parent(self, coord):
        if coord not in self.group_assignments:
            self.group_assignments[coord] = coord
            return coord

        parent = self.group_assignments[coord]

        if parent == coord:
            return coord

        top_boss = self.get_parent(parent)

        self.group_assignments[coord] = top_boss

        return top_boss

    def __str__(self):
        return self.group_assignments.__str__()


class GameManager:
    """
    White is 1, black is -1, none is 0
    size is 5, unless otherwisely stated.
    State is a tuple of to_play and board: (player_id:int, board:ndarray)
    white is top down, black is across
    """

    RELATIVE_HOOD = ((-1, 0), (-1, 1), (0, -1), (0, 1), (1, -1), (1, 0))

    def __init__(self, **kwargs):
        self.size = kwargs.get("size", 3)

    def legal_actions(self, state: tuple) -> list:
        """
        Get a list of all actions possible on the current board.
        """
        if np.ndim(state) != 1:
            raise ValueError("Input should be flat ndarray")
        assert isinstance(state, np.ndarray)

        _, board = np.split(state, [1])

        return [pos for pos, value in enumerate(board) if not value]

    def next_state(self, state: np.ndarray, action) -> np.ndarray:
        [player_id], board = np.split(state, [1])

        next_board = board.copy()

        assert isinstance(player_id, (int, np.integer))
        assert isinstance(action, (int, np.integer))
        assert action < self.size ** 2

        if bool(next_board[action]) is True:
            raise ValueError("Action location is occupied!")
        next_board[action] = player_id

        return np.insert(next_board, 0, -player_id)

    def terminal(self, state: np.ndarray):
        """
        A breadth-first search
        :param state:
        :return:
        """
        # okay, so only the last player to play, can be a winner and therefore can be the only one who triggers a
        # successful terminal call. This will be the opposite of player_id indicated player (-player_id). Therefore to
        # cut runtime, we only need to check for the last player to make a move.

        [player_id], board = np.split(state, [1])
        assert isinstance(player_id, (int, np.integer))
        prospective_player = -player_id

        dim_board = board.reshape((self.size, self.size))

        # This could be consolidated to one function using a axis variable but it will increase runtime.
        if prospective_player == 1:
            for y in range(self.size):
                if dim_board[0][y] == 1:
                    if self.dfs(start_pos=(0, y), board=dim_board, player=1):
                        return 1
            return 0
        elif prospective_player == -1:
            for x in range(self.size):
                if dim_board[x][0] == -1:
                    if self.dfs(start_pos=(x, 0), board=dim_board, player=-1):
                        return -1
            return 0
        else:
            raise ValueError(f"player_id must be -1 or 1, but it was {player_id}")

    def reward_dict(self, state: np.ndarray): # This method could use if terminal, but it is only called when this has already been asserted.
        return {-1: state[0], 1: -1*state[0]}  # if the state is -1, player1 gets 1, if state is 1, player 1 gets -1. This is inverted for player -1.

    def get_player(self, state):
        return state[0]

    def get_start_state(self) -> np.ndarray:
        x = np.zeros(self.size ** 2, dtype=np.int8)  # gen board
        return np.insert(x, 0, 1)  # add inn player

    def get_all_actions(self):
        return [i for i in range(self.size ** 2)]

    def total_legal_actions(self):
        return self.size ** 2

    def dfs(self, start_pos, board: np.ndarray, player):

        axis = 0 if player == 1 else 1

        dfs_positions = deque([start_pos])
        visited = np.zeros(board.shape)
        while dfs_positions:
            curr = dfs_positions[-1]
            visited[curr] = 1

            if curr[axis] == (self.size - 1):  # Checks if we have reached an end position
                return True

            found_unexploited_child = False
            for deltax, deltay in self.RELATIVE_HOOD:
                neigh = (curr[0] + deltax, curr[1] + deltay)
                if (0 < neigh[axis] < self.size) and (0 <= neigh[1 - axis] < self.size) and board[neigh] == player and \
                        not visited[neigh]:
                    dfs_positions.append(neigh)
                    found_unexploited_child = True
                    break

            if not found_unexploited_child:
                dfs_positions.pop()

        return False

    @staticmethod
    def state_symmetry_exploit(state):
        """
        Removes the player_id and flips to perspective as if player was white. Allows us to train for only one side and not symmetrically.
        :param state: the state given as a tuple on form (player_id, board)
        :return board: board from perspective of player as if player was white.
        """
        player_id, board = np.split(state, [1])
        assert bool(player_id)
        return board*player_id

    def state_symmetry(self, state):
        """
        Takes in the state and returns the board as a white-equivalent(as if the player was white but kept the state
        logically equal as before). If white is to play no change happens, but if it is black turn, the board is flipped
        and the pieces are inverted.
        :param state:
        :return:
        """
        player_id, board = np.split(state, [1])
        if player_id == -1:
            board = board.reshape((self.size, self.size)).T.reshape(board.shape)*(-1)
        return board

    def action_symmetry(self, state, action: np.ndarray):
        if state[0] == 1: # If already correct perspective, we want none of this, so we peace out.
            return action

        new = np.zeros(action.shape)
        for game_idx, action_probs in enumerate(action):
            for idx, value in enumerate(action_probs):
                mapped_idx = (idx % self.size)*self.size + (idx // self.size)
                new[game_idx, mapped_idx] = value
        return new

    def show(self, state):
        """
        Print an ascii representation of the game board. This is Eh, it works but is inverted, x is y and y is x.
        """
        player_id, board = np.split(state, [1])
        white = 'X'
        black = 'O'
        empty = '.'
        ret = '\n'
        coord_size = len(str(self.size))
        offset = 1
        ret += ' ' * (offset + 1)
        for x in range(self.size):
            ret += white + ' ' * offset * 2
        ret += '\n'
        for x in range(self.size):
            ret += black + ' ' * (offset * 2 + coord_size - len(str(x + 1)))
            for y in range(self.size):
                if (board[x*self.size + y] == 1):
                    ret += white
                elif (board[x*self.size + y] == -1):
                    ret += black
                else:
                    ret += empty
                ret += ' ' * offset * 2
            ret += black + "\n" + ' ' * offset * (x + 1)
        ret += ' ' * (offset * 2 + 1) + (white + ' ' * offset * 2) * self.size

        ret += '\n To Play: '
        if player_id == 1:
            ret += white
        else:
            ret += black

        return ret

    def visualize_networkx(self, state_list):



        # Build graph
        graph = nx.Graph()
        val = 0
        for row in range(self.size):
            for col in range(self.size):
                val += 1
                graph.add_node(val)
                if col > 0:
                    graph.add_edge(val, val - 1)
                if row > 0:
                    graph.add_edge(val, val - self.size)
                    if col < self.size - 1:
                        graph.add_edge(val, val - self.size + 1)

        colors = ["black", "red", "green"]
        pos = nx.drawing.spring_layout(graph, pos={1: np.asarray([0.01, 0.99])})  # Fixed position so we can overwrite.

        for idx, state in enumerate(state_list):

            player_id, board = np.split(state, [1])

            color_list = [colors[val] for val in board]

            nx.draw(graph, pos=pos, node_color=color_list, with_labels=False)
            try:
                plt.savefig("graph_pics/img_" + str(idx) + ".png")  # save in other file
            except FileNotFoundError:
                mkdir("graph_pics")
                plt.savefig("graph_pics/img_" + str(idx) + ".png")


def test_HexGame():
    H = GameManager(size=3)

    # state Non-dependents
    ss = H.get_start_state()
    assert ss[0] == 1
    for i in range(1, H.size):
        assert ss[i] == 0
    assert H.get_all_actions() == [i for i in range(H.size**2)]
    assert H.get_state_description() == np.asarray([i for i in range(H.size**2 + 1)]).shape
    assert H.total_legal_actions() == H.size**2

    print(H.state_symmetry(ss).reshape((3, 3)))
    s = H.next_state(ss, 3)
    assert s[4] == 1
    print(s[1:].reshape((3,3)))
    print(H.state_symmetry(s).reshape((3,3)))
    s = H.next_state(s, 0)
    assert s[1] == -1


    a = np.asarray([1, 1, -1,  1, -1,  -1,  1,  1, -1, -1])
    print(a[1:].reshape((3,3)))
    print(H.terminal(a))



if __name__ == '__main__':
    H = GameManager(size=4)

    states =[]

    s = H.get_start_state()
    states.append(s)
    for i in range(H.size**2):
        s = H.next_state(s, i)
        states.append(s)

    H.visualize_networkx(states)
