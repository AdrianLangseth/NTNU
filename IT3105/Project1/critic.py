class Critic:
    """
    Requirements:
    - must provide two different implementations for the critic: table and nn
    - manages the value function

    NB: States entering are of type flattened string
    """

    """
    The nn should work as follows:
    1. Get new state in. 
    2. Predict value of new state
    3. Save state in state list, save targets in list
    4. at end of episode, fit model.

    """

    def __init__(self, method: str, lr: float, critic_eligibility_decay_rate: float, discount_factor: float, input_size,
                 nn_dimensions: tuple=None):
        assert method.lower() in ["table", "nn"]

        self.method_type = method.lower()
        self.lr = lr
        self.eleg_decay_rate = critic_eligibility_decay_rate
        self.discount_rate = discount_factor
        self.episode_states_elegibility = {}  # Key: state, value: elegibility
        self.ordered_states = []

    def get_value(self, state):
        raise NotImplementedError

    def _update_value(self, state, v):
        raise NotImplementedError

    def calculate_td_error(self, new_state, reinforcement):
        delta = reinforcement + self.discount_rate * self.get_value(new_state) - self.get_value(self.ordered_states[-1])
        return delta

    def set_current_eligibility(self):
        self.episode_states_elegibility[self.ordered_states[-1]] = 1.0
        return True

    def update_episode_states(self, td_error: float):
        """
        iterate through states in episode, update state value(either through backprop or table update) , and then
        update all
        :return:
        """
        for state in self.ordered_states:
            # Update value function
            self._update_value(state, self.lr * td_error * self.episode_states_elegibility[state])
            # Update eligibility with decay
            self.episode_states_elegibility[state] = self.discount_rate * self.eleg_decay_rate * \
                                                     self.episode_states_elegibility[state]

    def reset_eligibilities(self):
        raise NotImplementedError()


if __name__ == '__main__':
    pass
