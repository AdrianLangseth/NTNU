import tensorflow.keras as ks
import tensorflow.keras.models as KM
import tensorflow.keras.layers as KL
import numpy as np
from splitGD import SplitGD
from critic import Critic


class CriticNN(Critic):
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
                 nn_dimensions: tuple, model_fp:str, pretrained:bool):  # = None):

        super().__init__(method=method, lr=lr, critic_eligibility_decay_rate=critic_eligibility_decay_rate,
                         discount_factor=discount_factor, input_size=input_size,
                         nn_dimensions=nn_dimensions)

        if nn_dimensions is None:
                raise ValueError("If method type is nn, dimensions must be set to something else than None")

        # REMOVE THIS IF MODEL SAVING IS ILLEGAL, AND REPLACE WITH ONLY THE LAST PART.
        if pretrained:
            try:
                self.keras_model = KM.load_model(model_fp)
            except (FileNotFoundError, OSError):
                self.keras_model = self._define_keras_model(layers=nn_dimensions, input_size=input_size)
        else:
            self.keras_model = self._define_keras_model(layers=nn_dimensions, input_size=input_size)
            
        self.split_model = SplitGD(self.keras_model)
        self.pretrained = pretrained

    def _update_value(self, state, target):
        state = np.asarray(list(map(int, state.strip("[]").split(" "))))

        self.split_model.fit(state, target, vfrac=0.)

    def get_value(self, state):
        if type(state) is str:
            state = np.asarray(list(map(int, state.strip("[]").split(" "))))

        elif not (type(state) is np.ndarray):
            raise TypeError(f"State should be of type ndarray (or str), however it was {type(state)}")

        return self.keras_model.predict(np.reshape(state, (1, -1)))

    def _define_keras_model(self, layers: tuple, input_size, optimizer="Adam", learning_rate=0.01, activation="relu",
               last_activation="linear", loss="mean_squared_error"):

        opt = eval('ks.optimizers.' + optimizer)
        act = eval('ks.activations.' + activation.lower())
        loss = eval("ks.losses." + loss)

        input_layer = KL.Input(shape=(input_size,))
        x = input_layer

        for nodes in layers:
            if nodes != 1:
                x = KL.Dense(nodes, activation=act)(x)
            else:
                x = KL.Dense(1, activation=last_activation)(x)

        model = KM.Model(input_layer, x)
        model.compile(optimizer=opt(lr=learning_rate), loss=loss)
        model.summary()
        return model

    def reset_eligibilities(self):
        self.split_model.reset_eligibility()

