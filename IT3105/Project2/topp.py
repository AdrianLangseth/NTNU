from hex_manager import GameManager
from rl_agent import *

from tensorflow.keras import models as KM
import warnings
from matplotlib import pyplot as plt
from tqdm import tqdm
from time import sleep


class TOPP:
    def __init__(self, size, model_filenames: [str], games: int, verbosity: bool, e_greedy: float, model_repo: str = "",
                 show_game: bool = False):
        self.env = GameManager(size=size)
        self.games = games
        self.agent_names = model_filenames
        self.verbosity = verbosity
        self.rate = False
        self.show_game = show_game

        self.agents = []
        for fp in model_filenames:
            agent = RL_Agent((3,), 1, [], [], self.env, model_repo + fp, e_greedy=e_greedy)  # The params here make no difference, only for loading.
            self.agents.append(agent)

    def round_robin(self, plot: bool):
        # if self.rate:
        #     p = np.load("rate.npy", allow_pickle=True)
        #     q = defaultdict(lambda: 2000.)
        #     q.update(p.item())

        # homeaway = [0, 0]
        leaderboard = np.zeros(len(self.agent_names))
        for idx1, agent1 in enumerate(self.agents):  # white
            for idx2, agent2 in enumerate(self.agents):  # black
                if idx1 == idx2:
                    continue

                # if self.rate:
                #     R_A = q[self.agent_names[idx1]]
                #     R_B = q[self.agent_names[idx2]]

                #     E_A = 1 / (1 + 10 ** ((R_B - R_A) / 400))
                #     E_B = 1 / (1 + 10 ** ((R_A - R_B) / 400))

                game_win = [0, 0]

                for _ in tqdm(range(self.games), disable=(not self.verbosity)):
                    state = self.env.get_start_state()
                    agent = agent1
                    while not self.env.terminal(state):
                        action = agent.default_policy(state)
                        state = self.env.next_state(state, action)

                        if self.show_game:
                            print(self.env.show(state))
                            print(action)

                        if agent == agent1:
                            agent = agent2
                        else:
                            agent = agent1

                    # self.show_game = False  # set show game back to false so we don't continue printing

                    # Get reward but only count positive as we want only game wins.
                    d = self.env.reward_dict(state)
                    game_win[0] += max(d[1], 0)
                    game_win[1] += max(d[-1], 0)


                print(f"In the matchup between H:{self.agent_names[idx1]} and A:{self.agent_names[idx2]} resulted in H {game_win[0]} - {game_win[1]} A")

                # if self.rate:
                #     q[self.agent_names[idx1]] = R_A + 10 * (game_win[0] - self.games * E_A)
                #     q[self.agent_names[idx2]] = R_B + 10 * (game_win[1] - self.games * E_B)

                leaderboard[idx1] += game_win[0]
                leaderboard[idx2] += game_win[1]
                # homeaway[0] += game_win[0]
                # homeaway[1] += game_win[1]

        # print(f"home win share: {homeaway[0] / sum(homeaway)}")
        # print(f"away win share: {homeaway[1] / sum(homeaway)}")

        # if self.rate:
        #     np.save('rate', np.array(dict(q)))

        if plot:
            labels = self.agent_names
            values = leaderboard

            plt.bar(labels, values)
            plt.show()


def test_model(model_path):
    env = GameManager(size=4)
    agent = RL_Agent((3,), 1, [], [], gm=env, model_load_path=model_path, e_greedy=0.1)
    s = np.asarray([1, -1, -1, -1, 1, -1, 0, 1, 0, 0, 1, 0, 0, -1, 0, 0, 0])
    print(s[1:].reshape((4, 4)))
    print(agent.default_policy(s))


def show_elo_board():
    q = np.load("rate.npy", allow_pickle=True)
    Q = dict(q.item())
    Q = {k: v for k, v in sorted(Q.items(), key=lambda item: item[1], reverse=True)}
    for i in Q.items():
        print(i)


if __name__ == '__main__':
    model_filenames = ["cnn-anakin_2500", "cnn-anakin_2600"]
    tourney = TOPP(size=6,
                   model_filenames=model_filenames,
                   games=50,
                   verbosity=True,
                   e_greedy=0.1,
                   show_game=False)

    tourney.round_robin(plot=True)

    # show_elo_board()
"""
    env = GameManager(size=6)

    agent = RL_Agent((3,), 1, [], [], env, "cnn-anakin_3000", e_greedy=0.)

    state = env.get_start_state()
    while True:
        state = env.next_state(state, agent.default_policy(state))
        print(env.show(state))
        if env.terminal(state):
            print("Robot won. Get good.")
            break
        action = int(input("Make move: "))
        state = env.next_state(state, action)
        if env.terminal(state):
            print(env.show(state))
            print("Human won. Get Fucked Tronny-boy.")
            break
"""

