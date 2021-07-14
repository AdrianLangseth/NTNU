import numpy as np
from critic import Critic


class CriticTable(Critic):
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
                 nn_dimensions: tuple = None):

        super().__init__(method=method, lr=lr, critic_eligibility_decay_rate=critic_eligibility_decay_rate,
                         discount_factor=discount_factor, input_size=input_size,
                         nn_dimensions=nn_dimensions)

        self.table_state_value = {}

    def get_value(self, state: np.ndarray):
        try:
            return self.table_state_value[str(state)]
        except KeyError:  # State not seen before, add it and set it to default value of a small random float.
            self.table_state_value[str(state)] = np.random.random() * 0.1
            return self.table_state_value[str(state)]

    def _update_value(self, state, increment):
        if state not in self.table_state_value:
            raise ValueError("This should never be triggered")
        else:
            self.table_state_value[state] += increment

    def reset_eligibilities(self):
        self.episode_states_elegibility = {}
