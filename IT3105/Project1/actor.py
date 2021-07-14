from numpy import ndarray
from random import random, choice


def decode_action(action_string: str) -> ((int, int), (int, int)):
    if type(action_string) is tuple:
        return action_string

    l = action_string.replace("(", "").replace(")", "").replace(" ", "").split(",")
    return tuple(list(map(int, l))[:2]), tuple(list(map(int, l))[2:])


class Actor:
    """
    Requirements:
    - on-policy: behaviour policy = target policy
    - must receive states and  from game
    """

    def __init__(self, lr: float, discount_factor: float,
                 actor_eligibility_decay_rate: float, e_greedy_rate: float,
                 e_greedy_decay_rate: float):

        self.lr = lr
        self.eleg_decay_rate = actor_eligibility_decay_rate
        self.discount_rate = discount_factor
        self.e_greedy = e_greedy_rate
        self.e_decay = e_greedy_decay_rate
        self.policy = {}
        self.episode_elegibility = {}  # Dictionary with (s,a) keys, elegibility values.
        self.ordered_state_action = []
        self.current_action = None
        self.new_action = None

        # #### POLICY TALK #####
        # Policy will be a dictionary with keys of state
        # Each state will have a seperate dictionary with keys of actions
        # Policy[state][action] gives the desirability of the action
        # this way we will encode ∏(s,a)

    def _get_state_policy_value(self, state: ndarray, action: (tuple, tuple)):
        if str(state) not in self.policy.keys():
            self.policy[str(state)] = {}
        elif str(action) not in self.policy.keys():
            self.policy[str(state)][str(action)] = 0

        return self.policy[str(state)][str(action)]

    def _get_state_policy(self, state: ndarray,
                          available_moves: list):
        """

        :param state:
        :param available_moves:
        :return: a string of a tuple of most beneficial move
        """
        if str(state) not in self.policy.keys():
            self.policy[str(state)] = {}
            for action in available_moves:
                self.policy[str(state)][str(action)] = 0

        if random() < self.e_greedy:
            return str(choice(available_moves))

        if len(available_moves):
            return max(self.policy[str(state)], key=lambda key: self.policy[str(state)][key])
        return None

    def get_new_action_on_new_state(self, new_state, available_moves: list):
        self.new_action = self._get_state_policy(new_state, available_moves)
        return self.new_action

    def set_elegibility_of_last_state_action(self):
        """
        set the eligibility value of a (s,a) pair to 1.
        :return: bool indicating success
        """
        state = self.ordered_state_action[-1][0]
        action = self.ordered_state_action[-1][1]

        self.episode_elegibility[(state, action)] = 1.0
        return True

    def update_episode_eligibilities(self):
        """
        sets the eligibility value of each (s,a) pair to its prev value * lr * eleg_deterioration_factor.
        :return: bool indicating success
        """
        for state, action in self.ordered_state_action:
            self.episode_elegibility[(state, action)] = self.discount_rate * self.eleg_decay_rate * \
                                                        self.episode_elegibility[(state, action)]
        return True

    def update_policy_of_episode_sa_pairs(self, td_error):
        """
        Updates the policy of state action pairs in episode by the formula based on TD_error
        :param td_error: calculates td_error from Critic.
        :return: bool indicating success
        """

        for state, action in self.ordered_state_action:
            error_term = self.lr * td_error * self.episode_elegibility[(state, action)]
            self.policy[state][action] += error_term

    def restate_action(self, new_state, action_on_new_state):
        self.ordered_state_action.append((new_state, action_on_new_state))
        self.current_action = self.new_action
        return True

    def reset_eligibilities(self):
        self.episode_elegibility.clear()
        self.e_greedy = self.e_greedy * self.e_decay
        return True
