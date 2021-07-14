# from anet import ActorNetwork
from cnet import ActorNetwork
from mcts import MCTS
from hex_manager import GameManager
import numpy as np
from random import random, choice
from timeit import timeit
from collections import defaultdict
from replay_buffer import ReplayBuffer


class RL_Agent:
    """
    Main activities:
    - Making actual moves in a game.
    - Making search moves during MCTS
    - Updating the target policy via supervised learning

    Must contain the ANET(the actor network)

    Should save net params to file

    """

    def __init__(self, input_shape, output_size, anet_layer_sizes, anet_layer_activations, gm: GameManager,
                 model_load_path, e_greedy, lr=0.01, optimizer="adam"):
        self.e_greedy = e_greedy
        self.anet = ActorNetwork(hidden_layer_sizes=anet_layer_sizes,
                                 hidden_activations=anet_layer_activations,
                                 optimizer=optimizer,
                                 input_shape=input_shape,
                                 output_size=output_size,
                                 model_load_path=model_load_path,
                                 gm=gm,
                                 lr=lr)

        self.rbuf = ReplayBuffer(size_x=len(gm.get_start_state()),
                                 size_y=output_size,
                                 max_size=5000,
                                 default_batch_size=64)
        self.env = gm

    def normalize_action_values(self, action_values, actions_available):
        d = defaultdict()
        all_act = self.env.get_all_actions()
        for action in actions_available:
            idx = all_act.index(action)
            d[action] = action_values[-1][idx]
        return {k: v / total for total in (sum(d.values()),) for k, v in d.items()}

    def default_policy(self, state):  # make general for game.
        moves = self.env.legal_actions(state)
        if random() < self.e_greedy:
            return choice(moves)

        prediction = self.anet.predict(state)
        normalized_prediction = self.normalize_action_values(prediction, moves)  # too slow!
        return max(normalized_prediction, key=lambda action: normalized_prediction[action])

    def retain(self, state, edge_visits):

        self.rbuf.append(x=state, y=self.get_distribution(edge_visits))

    def get_distribution(self, edge_visits: dict):
        """
        dict should be on form {action:visits}
        :param Edge_visits:
        :return:
        """
        all_acts = self.env.get_all_actions()
        distribution = np.zeros(len(all_acts))
        s = sum(edge_visits.values())
        for action, visits in edge_visits.items():
            idx = all_acts.index(action)
            distribution[idx] = visits / s
        return distribution

    def train_rbuf(self, verbose):
        history = self.anet.train(self.rbuf.minibatch())
        if verbose:
            # do something about loss
            print(history.history["loss"])
        return history

    def extend_saved_rbuf(self):
        self.rbuf.save()

