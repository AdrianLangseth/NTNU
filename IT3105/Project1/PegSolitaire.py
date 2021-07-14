import numpy as np
from copy import deepcopy


def get_landing_pos(move_peg_pos: (int, int), target_peg_pos: (int, int)):
    landing_x = 2 * target_peg_pos[0] - move_peg_pos[0]
    landing_y = 2 * target_peg_pos[1] - move_peg_pos[1]
    return landing_x, landing_y


def sumtri(array) -> int:
    s = 0
    for i in array:
        for v in i:
            s += v
    return s


class PegSolitaire:
    """
    Must provide the following to the critic:

    * State | get_state()
    *
    """
    def __init__(self, type: str, size: int, open_holes: list, win_reward=1., move_penalty=-0.01, loss_penalty=-0.1):
        self.size = size
        self.win_reward = win_reward
        self.move_penalty = move_penalty
        self.loss_penalty = loss_penalty
        if type.lower() == "d" or type.lower() == "diamond":
            self.board = np.ones((size, size), dtype=int)
            self.type = "d"
        elif type.lower() == "t" or type.lower() == "triangle":
            self.type = "t"
            self.board = []
            for i in range(size):
                self.board.append(np.ones(i + 1, dtype=int)),
            self.board = np.asarray(self.board)
        else:
            raise ValueError("Peg Solitaire must be of shape Diamond or Triangle and must be denoted"
                             "\"D/Diamond\" or \" T/Triangle\" ")
        for x, y in open_holes:
            if self._valid_location(x, y):
                self.board[x][y] = 0
            else:
                print(f"{(x,y)} was not recognised as a valild location in the given board. It was therefore skipped.")

    def get_filled_status(self, x, y) -> bool:
        return self.board[x][y]

    def _valid_location(self, x, y) -> bool:
        if self.type == "d":
            if 0 <= x < self.size and 0 <= y < self.size:
                return True
            return False
        elif self.type == "t":
            if 0 <= x < self.size and 0 <= y <= x:
                return True
            return False
        else:
            raise ValueError("Typen Her burde ha vært \"d\" eller \"t\", men det er den ikke.")

    def get_neighborhood(self, x, y) -> list:
        l = []
        if self.type == "d":
            if x > 0:
                l.append((x - 1, y))
            if y > 0:
                l.append((x, y - 1))
            if x < self.size - 1:
                l.append((x + 1, y))
            if y < self.size - 1:
                l.append((x, y + 1))
            if x > 0 and y < self.size - 1:
                l.append((x - 1, y + 1))
            if y > 0 and x < self.size - 1:
                l.append((x + 1, y - 1))
        elif self.type == "t":
            if y > 0:
                l.append((x, y - 1))
                if x > 0:
                    l.append((x - 1, y - 1))
            if x > 0 and y < x:
                l.append((x - 1, y))
            if y < self.size - 1 and y < x:
                l.append((x, y + 1))
            if x < self.size - 1:
                l.append((x + 1, y))
                l.append((x + 1, y + 1))
        else:
            raise ValueError("Typen Her burde ha vært \"d\" eller \"t\", men det er den ikke.")
        return sorted(l)

    def valid_move(self, move_peg_position: tuple, target_peg_position: tuple) -> bool:

        def check_valid_landing_spot() -> bool:
            """
            Helper for checking whether landing spot is valid
            :return: True if the spot is a valid location AND it is not already filled.
            """
            landing_x, landing_y = get_landing_pos(move_peg_position, target_peg_position)
            return self._valid_location(landing_x, landing_y) and not self.get_filled_status(landing_x, landing_y)

        def check_valid_pieces() -> bool:
            return self.get_filled_status(*move_peg_position) and self.get_filled_status(*target_peg_position)

        def check_neighborness():
            """
            Check wether the two spots are in neighborhood of each other
            :return: True/False
            """
            return target_peg_position in self.get_neighborhood(*move_peg_position)

        return check_valid_landing_spot() and check_valid_pieces() and check_neighborness()

    def _get_pos_pairs(self) -> (list, list):
        positions = []
        filled_positions = []
        for x, row in enumerate(self.board):
            for y, col in enumerate(row):
                positions.append((x, y))
                if col:
                    filled_positions.append((x, y))
        return positions, filled_positions

    def get_available_moves(self) -> list:
        available_moves = []
        n, f = self._get_pos_pairs()
        for move_peg_pos in f:
            for target_peg_pos in f:
                if self.valid_move(move_peg_position=move_peg_pos, target_peg_position=target_peg_pos):
                    available_moves.append((move_peg_pos, target_peg_pos))
        return sorted(available_moves)

    def get_state(self) -> str:
        x = []
        for i in self.board:
            for ii in i:
                x.append(ii)
        return str(np.asarray(x))


    def is_win(self) -> bool:
        return bool(sumtri(self.board) == 1)

    def _is_loss(self) -> bool:
        return not len(self.get_available_moves()) and not self.is_win()

    def _remove_peg(self, pos_x: int, pos_y: int) -> bool:
        if self.board[pos_x][pos_y]:
            self.board[pos_x][pos_y] = 0
            return True
        else:
            raise ValueError("The position", (pos_x, pos_y), "should be filled to be removed, but it was empty")

    def _add_peg(self, pos_x: int, pos_y: int) -> bool:
        if not self.board[pos_x][pos_y]:
            self.board[pos_x][pos_y] = 1
            return True
        else:
            raise ValueError("The position", (pos_x, pos_y), "should be empty to add peg, but it was already filled")

    def make_move(self, move_peg_pos: tuple, target_peg_pos: tuple) -> (bool, float):
        """
        Method for making a move. Should take part in pushing old state, new state, reinforcement to Critic,
        and old state, new state, action and action_space to ACTOR.
        :param move_peg_pos: position of peg to be moved
        :param target_peg_pos: position of peg to be "jumped over"
        :return: success, reinforcement, new state
        """
        if self.valid_move(move_peg_position=move_peg_pos, target_peg_position=target_peg_pos):
            landing_pos = get_landing_pos(move_peg_pos, target_peg_pos)
            self._add_peg(*landing_pos)
            self._remove_peg(*move_peg_pos)
            self._remove_peg(*target_peg_pos)
            if self.is_win():
                return True, self.win_reward - self.move_penalty
            elif self._is_loss():
                return True, self.loss_penalty*self.get_remaining_pegs_count()
            return True, self.move_penalty
        return False, None

    def _get_reward_of_move(self, movetuple: tuple) -> float:
        """
        This function is not used internally and should not be used by either Actor or Critic. Leave for now. ToDo
        :param movetuple:
        :return:
        """

        def temp_remove_peg(temp_board, pos_x, pos_y) -> bool:
            if temp_board[pos_x][pos_y]:
                temp_board[pos_x][pos_y] = 0
                return True
            else:
                raise ValueError("The position", (pos_x, pos_y), "should be filled to be removed, but it was empty")

        def temp_add_peg(temp_board, pos_x: int, pos_y: int) -> bool:
            if not temp_board[pos_x][pos_y]:
                temp_board[pos_x][pos_y] = 1
                return True
            else:
                raise ValueError("The position", (pos_x, pos_y),
                                 "should be empty to add peg, but it was already filled")

        if self.valid_move(*movetuple):
            temp_board = deepcopy(self.board)
            landing_pos = get_landing_pos(*movetuple)
            temp_add_peg(temp_board, *landing_pos)
            temp_remove_peg(temp_board, *movetuple[0])
            temp_remove_peg(temp_board, *movetuple[1])

            if sumtri(temp_board) == 1:
                return self.win_reward
            else:
                return self.move_penalty
        else:
            raise ValueError("Invalid_move")

    def get_remaining_pegs_count(self):
        _, filled = self._get_pos_pairs()
        return len(filled)

    def reset_board_for_new_ep(self):
        pass


def testing():
    x = PegSolitaire("d", 3, [(0, 1), (0, 0), (0, 2)])
    y = PegSolitaire("T", 3, [(1, 0), (2, 2)])

    def test_valid_location():
        assert (x._valid_location(-1, 2) is False)
        assert (x._valid_location(0, 0) is True)
        assert (x._valid_location(2, 2) is True)
        assert (x._valid_location(2, 3) is False)
        assert (x._valid_location(3, 2) is False)
        assert (y._valid_location(1, 2) is False)
        assert (y._valid_location(-3, 2) is False)
        assert (y._valid_location(4, 4) is False)
        assert (y._valid_location(2, 2) is True)

    def test_get_neighborhood():
        # test for Diamond:
        assert x.get_neighborhood(0, 0) == [(0, 1), (1, 0)]
        assert x.get_neighborhood(0, 1) == [(0, 0), (0, 2), (1, 0), (1, 1)]
        assert x.get_neighborhood(0, 2) == [(0, 1), (1, 1), (1, 2)]
        assert x.get_neighborhood(1, 0) == [(0, 0), (0, 1), (1, 1), (2, 0)]
        assert x.get_neighborhood(1, 1) == [(0, 1), (0, 2), (1, 0), (1, 2), (2, 0), (2, 1)]
        assert x.get_neighborhood(1, 2) == [(0, 2), (1, 1), (2, 1), (2, 2)]
        assert x.get_neighborhood(2, 0) == [(1, 0), (1, 1), (2, 1)]
        assert x.get_neighborhood(2, 1) == [(1, 1), (1, 2), (2, 0), (2, 2)]
        assert x.get_neighborhood(2, 2) == [(1, 2), (2, 1)]

        # test for Triangle
        assert y.get_neighborhood(0, 0) == [(1, 0), (1, 1)]
        assert y.get_neighborhood(1, 0) == [(0, 0), (1, 1), (2, 0), (2, 1)]
        assert y.get_neighborhood(1, 1) == [(0, 0), (1, 0), (2, 1), (2, 2)]
        assert y.get_neighborhood(2, 0) == [(1, 0), (2, 1)]
        assert y.get_neighborhood(2, 1) == [(1, 0), (1, 1), (2, 0), (2, 2)]
        assert y.get_neighborhood(2, 2) == [(1, 1), (2, 1)]

    def test_valid_move():
        assert x.valid_move((2, 0), (1, 0)) is True
        assert x.valid_move((2, 1), (1, 1)) is True
        assert x.valid_move((2, 0), (1, 1)) is True
        assert x.valid_move((2, 2), (1, 2)) is True
        assert x.valid_move((2, 2), (1, 1)) is False
        assert x.valid_move((2, 1), (2, 2)) is False
        assert x.valid_move((1, 1), (0, 2)) is False
        assert x.valid_move((2, 0), (2, 2)) is False

        assert y.valid_move((2, 0), (2, 1)) is True
        assert y.valid_move((0, 0), (1, 1)) is True
        assert y.valid_move((0, 0), (1, 0)) is False
        assert y.valid_move((2, 1), (2, 2)) is False
        assert y.valid_move((2, 0), (1, 1)) is False
        assert y.valid_move((2, 1), (2, 0)) is False

    def test_win():
        a = PegSolitaire("d", 3, [(0, 0), (0, 1), (0, 2), (1, 0), (1, 1), (1, 2), (2, 0), (2, 1)])
        b = PegSolitaire("d", 3, [(0, 0), (0, 1), (0, 2), (1, 1), (1, 2), (2, 0), (2, 1), (2, 2)])
        c = PegSolitaire("d", 3, [(0, 0), (0, 1), (0, 2), (1, 0), (1, 1), (1, 2), (2, 0)])
        d = PegSolitaire("d", 3, [])
        assert a.is_win()
        assert b.is_win()
        assert c.is_win() is False
        assert d.is_win() is False

    def test_loss():
        a = PegSolitaire("d", 3, [(0, 1), (0, 2), (1, 0), (1, 1), (1, 2), (2, 0), (2, 1)])
        b = PegSolitaire("d", 3, [(0, 0), (0, 1), (1, 1), (1, 2), (2, 0), (2, 1)])
        c = PegSolitaire("d", 3, [(0, 0), (0, 1), (0, 2), (1, 0), (1, 1), (1, 2), (2, 0), (2, 1)])
        d = PegSolitaire("d", 3, [(0, 0)])
        e = PegSolitaire("d", 3, [])
        assert a._is_loss()
        assert b._is_loss()
        assert c._is_loss() is False
        assert d._is_loss() is False
        assert e._is_loss()

    def test_get_pos_pairs():
        n, f = x._get_pos_pairs()
        assert n == [(0, 0), (0, 1), (0, 2), (1, 0), (1, 1), (1, 2), (2, 0), (2, 1), (2, 2)]
        assert f == [(1, 0), (1, 1), (1, 2), (2, 0), (2, 1), (2, 2)]
        n, f = y._get_pos_pairs()
        assert n == [(0, 0), (1, 0), (1, 1), (2, 0), (2, 1), (2, 2)]
        assert f == [(0, 0), (1, 1), (2, 0), (2, 1)]

    def test_get_available_moves():
        assert x.get_available_moves() == sorted(
            [((2, 0), (1, 0)), ((2, 1), (1, 1)), ((2, 0), (1, 1)), ((2, 2), (1, 2))])
        assert y.get_available_moves() == sorted(
            [((0, 0), (1, 1)), ((2, 0), (2, 1))])

    def test_get_landing_pos():
        assert get_landing_pos((0, 0), (1, 1)) == (2, 2)
        assert get_landing_pos((0, 1), (1, 1)) == (2, 1)
        assert get_landing_pos((0, 2), (1, 1)) == (2, 0)
        assert get_landing_pos((2, 0), (1, 1)) == (0, 2)
        assert get_landing_pos((1, 0), (1, 1)) == (1, 2)
        assert get_landing_pos((2, 2), (1, 1)) == (0, 0)
        assert get_landing_pos((1, 2), (1, 1)) == (1, 0)

    def test_make_move():
        d = PegSolitaire("d", 3, [(0, 1), (0, 0), (0, 2)])
        t = PegSolitaire("T", 3, [(1, 0), (2, 2), (2, 0)])
        assert t.get_reward_of_move(((0, 0), (1, 1))) == -0.01
        assert t.make_move((0, 0), (1, 1)) == (True, -0.01)
        # assert t.board == [[0], [0, 0], [0, 1, 1]]
        assert t.get_reward_of_move(((2, 2), (2, 1))) == 1.
        assert t.make_move((2, 2), (2, 1)) == (True, 1.)
        # assert t.board == [[0], [0, 0], [1, 0, 0]]
        assert t.is_win() is True
        assert t._is_loss() is False

        assert d.get_reward_of_move(((2, 0), (1, 0))) == -0.01
        assert d.make_move((2, 0), (1, 0)) == (True, -0.01)
        assert (d.board == [[1, 0, 0], [0, 1, 1], [0, 1, 1]]).all()
        assert d.get_reward_of_move(((2, 1), (1, 1))) == -0.01
        assert d.make_move((2, 1), (1, 1)) == (True, -0.01)
        assert (d.board == [[1, 1, 0], [0, 0, 1], [0, 0, 1]]).all()
        assert d.get_reward_of_move(((0, 0), (0, 1))) == -0.01
        assert d.make_move((0, 0), (0, 1)) == (True, -0.01)
        assert (d.board == [[0, 0, 1], [0, 0, 1], [0, 0, 1]]).all()
        assert d.is_win() is False
        assert d._is_loss()

    test_valid_location()
    test_get_neighborhood()
    test_valid_move()
    test_win()
    test_loss()
    test_get_pos_pairs()
    test_get_available_moves()
    test_get_landing_pos()
    test_make_move()
    print("We good")


if __name__ == "__main__":
    testing()
