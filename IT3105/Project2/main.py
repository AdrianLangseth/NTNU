from hex_manager import GameManager
from copy import deepcopy
from rl_agent import RL_Agent
from mcts import MCTS, Node
from configparser import ConfigParser
from tqdm.contrib.telegram import tqdm
from matplotlib import pyplot as plt
from time import perf_counter
import numpy as np


class MainAlgorithm():
    def __init__(self, size, anet_layer_sizes, anet_layer_activations, actual_games, search_games, save_agents: int,
                 e_greedy:float, max_search_time:float = np.inf, optimizer="adam", learning_rate=0.01, model_path=None,
                 replay_buffer_path=None):
        self.env = GameManager(size=size)
        self.rbuf_path = replay_buffer_path
        self.agent = RL_Agent(input_shape=(size**2,),
                              output_size=size**2,
                              anet_layer_sizes=anet_layer_sizes,
                              anet_layer_activations=anet_layer_activations,
                              gm=self.env,
                              model_load_path=model_path,
                              e_greedy=e_greedy,
                              optimizer=optimizer,
                              lr=learning_rate)
        self.actual_games = actual_games
        self.search_games = search_games
        self.max_search_time = max_search_time
        self.save_agents = save_agents
        self.e_greedy = e_greedy

    def run(self, save_path_prefix, viz_game:list=[]):

        # Save initial ANET
        expanded = True
        if self.save_agents and False:
            self.agent.anet.save_model(f"{save_path_prefix}_0")
        if self.rbuf_path is not None:
            self.agent.rbuf.load(self.rbuf_path)

        losses = []

        for gameNum in tqdm(range(self.actual_games), token="", chat_id=''):

            # root_node = Node(self.env.get_start_state(), None)
            # mcts = MCTS(env=self.env, root_node=root_node, e_greedy=self.e_greedy)
            """
            while not self.env.terminal(mcts.root.state):
                mcts.search_games(max_amount=self.search_games,
                                  max_time=self.max_search_time,
                                  default_policy=self.agent.default_policy,
                                  exploration_factor=1.)

                root_state, E = mcts.get_root_edge_visits()
                self.agent.retain(root_state, E)

                action = np.random.choice(list(E.keys()), p=(list(E.values()))/np.sum(list(E.values())))

                mcts.set_root(action)

                if gameNum in viz_game:
                    print(self.env.show(mcts.root.state))
            """
            history = self.agent.train_rbuf(verbose=False)
            losses.append(history.history["loss"])


            # If we hit a interval, save for TOPP. If game_count % M == 0: save ANET.
            if (self.save_agents > 1) and (not (gameNum + 1) % int(self.actual_games / (self.save_agents - 1))):
                self.agent.anet.save_model(f"{save_path_prefix}_{gameNum+3451}")

        # Extend the saved rbuf with new data
        if self.rbuf_path is not None and False:
            self.agent.rbuf.save(self.rbuf_path)

        plt.plot(losses)
        plt.show()


if __name__ == '__main__':

    # Create game
    MainAlgorithm(
        size=6,
        anet_layer_sizes=[50, 25],
        anet_layer_activations=["relu", "relu"],
        optimizer="adam",
        e_greedy=0.1,
        actual_games=200,
        search_games=1,
        max_search_time=1.,
        save_agents=2,
        replay_buffer_path="6replaybuffer-anakin",
        learning_rate=0.001,
        model_path="cnn-anakin_3450"
    ).run(
        save_path_prefix="from_best_anakin",
        viz_game=[]
    )
