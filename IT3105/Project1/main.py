from PegSolitaire import PegSolitaire
from configparser import ConfigParser
from re import split as resp
from Agent import Agent
import numpy as np
from matplotlib import pyplot as plt
import networkx as nx
import tensorflow as tf
from os import mkdir
# from tqdm import tqdm
from critic_nn import CriticNN
from tqdm.contrib.telegram import tqdm


class Network:
    def __init__(self, type: str, size: int, open_holes: [(int, int)], episodes: int, critic_method: str,
                 actor_learning_rate: float, critic_learning_rate: float, actor_eligibility_decay_rate: float,
                 critic_eligibility_decay_rate: float, actor_discount_factor: float, critic_discount_factor: float,
                 display_at_end: bool, frame_delay: int, e_greedy_rate: float, e_greedy_decay_rate: float = 0,
                 pretrained=False, nn_dimensions: tuple = None, save_model=False):

        self.game = PegSolitaire(type, size, open_holes)
        self.board_type = type
        self.board_size = size
        self.open_holes = open_holes
        if board_type == "d":
            state_size = size ** 2
        elif board_type == "t":
            state_size = int(size * (size + 1) / 2)
        else:
            state_size = 0

        self.agent = Agent(critic_mode=critic_method,
                           actor_learning_rate=actor_learning_rate,
                           critic_learning_rate=critic_learning_rate,
                           actor_discount_factor=actor_discount_factor,
                           critic_discount_factor=critic_discount_factor,
                           e_greedy_rate=e_greedy_rate,
                           e_greedy_decay_rate=e_greedy_decay_rate,
                           critic_eligibility_decay_rate=critic_eligibility_decay_rate,
                           actor_eligibility_decay_rate=actor_eligibility_decay_rate,
                           nn_dimensions=nn_dimensions,
                           state_size=state_size,
                           pretrained=pretrained,
                           model_fp=f"models/{board_type}_{size}")

        self.remaining_pegs_list = []
        self.eps = episodes
        self.display_at_end = display_at_end
        self.start_e_greedy = e_greedy_rate
        self.e_greedy_decay = e_greedy_decay_rate
        self.save_model = save_model

# -###################__Episode_runs__###################-  #
    def run_episode(self):
        self.game = PegSolitaire(self.board_type, self.board_size, self.open_holes)

        self.agent.reset_elegibilities()
        action = self.agent.initialize_state_and_action(self.game.get_state(), self.game.get_available_moves())

        while True:
            succ, reinforcement = self.game.make_move(action[0], action[1])
            assert succ

            new_state = self.game.get_state()
            available_moves = self.game.get_available_moves()

            last_step_of_ep = not bool(len(self.game.get_available_moves()))

            action = self.agent.time_step(all_availiable_actions=available_moves, new_state=new_state,
                                          reinforcement=reinforcement, last_step_of_ep=last_step_of_ep)

            if last_step_of_ep:
                self.remaining_pegs_list.append(self.game.get_remaining_pegs_count())
                break

    def run_episodes(self):
        for ep in tqdm(range(self.eps), token="", chat_id=''):
            self.run_episode()
            # if not ep % 100 and ep:
                # self.visualize_learning_progression()

        # If we are using a nn, we don't want to run it again, because it takes 20 minutes. So we save it.
        if isinstance(self.agent.critic, CriticNN) and self.save_model:
            self.agent.critic.keras_model.save(f"models/{board_type}_{size}")


        # Now run single visualized run with e-greedy = 0
        self.agent.actor.e_greedy = 0
        self.run_episode()

        print(f"For the last episode we will use a \u03B5-greedy rate of {self.agent.actor.e_greedy}.")
        print(f"Amount of pegs remaining when using this configuration: {self.remaining_pegs_list[-1]} \n")

        self.visualize_learning_progression()

        if self.display_at_end:
            self.visualize_one_episode()

# -###################__Visualisation__###################- #
    def visualize_learning_progression(self):

        fig, ax = plt.subplots()

        ax.plot([i for i in range(len(self.remaining_pegs_list))], self.remaining_pegs_list, 'k-', label="Remaining Pegs",
                linewidth=.25)

        ma = 25
        ax.plot([i for i in range(ma - 1, len(self.remaining_pegs_list))],
                np.convolve(self.remaining_pegs_list, np.ones(ma), 'valid') / ma, 'm-', label=f"moving_average({ma})")

        ax2 = ax.twinx()

        x = np.arange(0, len(self.remaining_pegs_list), 1.0)
        y = self.start_e_greedy * (self.e_greedy_decay ** x)

        ax2.plot(x, y, 'c-', label="\u03B5-greedy_rate")

        ax.set_ylabel("Amount of pegs remaining")
        ax2.set_ylabel('\u03B5-greedy rate')

        ax2.set_ylim(0., 1.)
        ax.set_ylim(bottom=1)

        fig.suptitle("Progression on Episodes")
        ax.set_xlabel("Episode")

        ax.legend(loc="upper left")
        ax2.legend(loc="upper right")

        plt.show()

    def visualize_networkx(self, state_list, action_list):
        # Build graph
        graph = nx.Graph()
        val = 0
        if self.board_type == "t":
            for row in range(self.board_size):
                for pos in range(row + 1):
                    val += 1
                    graph.add_node(val)
                    if row > 0:
                        if pos < row:
                            graph.add_edge(val, val - row)
                        if pos > 0:
                            graph.add_edge(val, val - 1)
                            graph.add_edge(val, val - row - 1)
        elif self.board_type == "d":
            for row in range(self.board_size):
                for col in range(self.board_size):
                    val += 1
                    graph.add_node(val)
                    if col > 0:
                        graph.add_edge(val, val - 1)
                    if row > 0:
                        graph.add_edge(val, val - self.board_size)
                        if col < self.board_size - 1:
                            graph.add_edge(val, val - self.board_size + 1)

        colors = ["black", "red", "green"]
        pos = nx.drawing.spring_layout(graph)  # Fixed position so we can overwrite.

        for idx, (state, action) in enumerate(zip(state_list, action_list)):

            # Color each space according to its filled state
            color_list = [colors[val] for val in state]

            # save img
            nx.draw(graph, pos=pos, node_color=color_list, with_labels=False)
            try:
                plt.savefig("graph_pics/img_" + str(2 * idx) + ".png")  # save in other file
            except FileNotFoundError:
                mkdir("graph_pics")
                plt.savefig("graph_pics/img_" + str(2 * idx) + ".png")

            # add_action_peg
            for involved in action:  # color in each peg involved in action. Values map differently for diff types.
                if self.board_type == "t":
                    val = involved[0] * (1 + involved[0]) // 2 + involved[1]
                elif self.board_type == "d":
                    val = involved[0] * self.board_size + involved[1]
                color_list[val] = colors[2]
            nx.draw(graph, pos=pos, node_color=color_list, with_labels=False)

            # save img
            plt.savefig("graph_pics/img_" + str(2 * idx + 1) + ".png")

        # Add values of final state
        nx.draw(graph, pos=pos, node_color=[colors[val] for val in state_list[-1]], with_labels=False)
        plt.savefig("graph_pics/img_" + str(2 * idx + 2) + ".png")

    def visualize_one_episode(self):
        # This is very similar to running an episode, but here we keep hold of action and state list for visualisation.
        self.game = PegSolitaire(self.board_type, self.board_size, self.open_holes)

        self.agent.reset_elegibilities()
        action_list = []
        state_list = []

        action = self.agent.initialize_state_and_action(self.game.get_state(), self.game.get_available_moves())
        action_list.append(action)
        state_list.append(list(map(int, self.game.get_state().strip("[]").split(" "))))

        while True:
            succ, reinforcement = self.game.make_move(action[0], action[1])
            assert succ

            new_state = self.game.get_state()
            state_list.append(list(map(int, self.game.get_state().strip("[]").split(" "))))
            available_moves = self.game.get_available_moves()

            last_step_of_ep = not bool(len(self.game.get_available_moves()))

            action = self.agent.time_step(all_availiable_actions=available_moves, new_state=new_state,
                                          reinforcement=reinforcement, last_step_of_ep=last_step_of_ep)

            if last_step_of_ep:
                print(f"As a visualisation of the last episode was requested, the network ran a single extra episode "
                      f"for this purpose. This resulted in {self.game.get_remaining_pegs_count()} remaining pegs.")
                print(f"The images of states and actions are saved in the \"graph_pics\" directory.")
                break
            action_list.append(action)

        self.visualize_networkx(state_list, action_list)


# Helper Function
def str_to_list(s: str) -> list:
    """
    Quick helper function for parsing a string-encoded list to a pure list
    :param s: string-encoded list
    :return: list
    """
    s = resp('\)\s*,\s*\(', s)
    sl = []
    for i in s:
        sl.append(i.strip("[]()"))
    s = []
    for i in sl:
        s.append((int(i[0]), int(i[-1])))
    return s


if __name__ == '__main__':
    # Set seeds for consistency
    np.random.seed(420)
    tf.random.set_seed(420)

    # Instantiate configParser with file
    config_object = ConfigParser()
    config_object.read('config.ini')

    board = config_object["BOARD"]
    actor = config_object["ACTOR"]
    critic = config_object["CRITIC"]
    general = config_object["GENERAL"]

    board_type = board["board_type"]
    size = int(board["board_size"])
    open_holes = str_to_list(board["open_holes"])
    episodes = int(board["episodes"])

    critic_method = critic["critic_method"]
    nn_dimensions = tuple(map(int, critic["nn_dimensions"].strip("()").split(', ')))
    critic_learning_rate = float(critic["learning_rate"])
    critic_eligibility_decay_rate = float(critic["eligibility_decay_rate"])
    critic_discount_rate = float(critic["discount_rate"])
    pretrained = config_object.getboolean('CRITIC', "pretrained")
    save_model = config_object.getboolean('CRITIC', "save_model")

    actor_eligibility_decay_rate = float(actor["eligibility_decay_rate"])
    actor_discount_rate = float(actor["discount_rate"])
    actor_learning_rate = float(actor["learning_rate"])
    e_constant = float(general["e_rate"])
    frame_delay = float(general["frame_delay"])
    e_greedy_decay_rate = float(general["e_greedy_decay_rate"])
    display_at_end = config_object.getboolean('GENERAL', "display_at_end")

    # Create the network
    m = Network(type=board_type, size=size, open_holes=open_holes, episodes=episodes, critic_method=critic_method,
                nn_dimensions=nn_dimensions, actor_learning_rate=actor_learning_rate,
                critic_learning_rate=critic_learning_rate, actor_eligibility_decay_rate=actor_eligibility_decay_rate,
                critic_eligibility_decay_rate=critic_eligibility_decay_rate, actor_discount_factor=actor_discount_rate,
                critic_discount_factor=critic_discount_rate, e_greedy_rate=e_constant, frame_delay=int(frame_delay),
                e_greedy_decay_rate=e_greedy_decay_rate, display_at_end=display_at_end, pretrained=pretrained,
                save_model=save_model)

    # Run the episodes
    m.run_episodes()
