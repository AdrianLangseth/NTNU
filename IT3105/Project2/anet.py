from tensorflow.keras import layers as KL
from tensorflow.keras import activations as KA
from tensorflow.keras import models as KM
from tensorflow.keras import Model
from tensorflow.keras import optimizers as KO
import tensorflow as tf
from numpy import atleast_2d
import numpy as np
from hex_manager import GameManager


class ActorNetwork:
    ACTS = {"linear": KA.linear, "sigmoid": KA.sigmoid, "tanh": KA.tanh, "relu": KA.relu}  # maps the str to the func
    OPTS = {"adam": KO.Adam, "adagrad": KO.Adagrad, "rmsprop": KO.RMSprop, "sgd": KO.SGD}

    def __init__(self, hidden_layer_sizes, hidden_activations, optimizer: str, input_shape, output_size: int,
                 model_load_path, gm:GameManager, lr=0.01):
        self.minibatch_size = 128
        self.env = gm

        if model_load_path is None:

            input_layer = KL.Input(shape=input_shape)  # Board is NxN, and also pass turn.
            x = input_layer
            for size, act in zip(hidden_layer_sizes, hidden_activations):
                x = KL.Dense(size, activation=act)(x)
            outputs = KL.Dense(output_size, activation="softmax")(x)

            self.model = Model(inputs=input_layer, outputs=outputs)
            print("Model Generated:")
            self.model.summary()
            self.model.compile(optimizer=self.OPTS[optimizer](learning_rate=lr), loss=custom_loss) # , steps_per_execution=2)

        else:
            self.load_model(model_load_path)

    def predict(self, state):
        """
        Takes in a state, symmetry-hack, gets the predicted distribution, symmetry-hack back, pass on
        distribution(correct according to actual board)
        :param state: state as all others perceive it
        :return:
        """
        assert isinstance(state, np.ndarray)


        # state_symmetry
        board = self.env.state_symmetry(state)

        # prediction
        predictions = self.model.predict(atleast_2d(board))

        assert isinstance(predictions, np.ndarray)

        # invers action symmetry
        action = self.env.action_symmetry(state=state, action=predictions)

        assert isinstance(action, np.ndarray)

        return action

    def save_weights(self, folder_path):
        raise NotImplementedError

    def load_weights(self):
        raise NotImplementedError

    def save_model(self, model_name):
        self.model.save(f"saved_models/{model_name}")

    def load_model(self, model_name):
        try:
            self.model = KM.load_model(f"saved_models/{model_name}")
        except ValueError:
            self.model = KM.load_model(f"saved_models/{model_name}", custom_objects={'custom_loss': custom_loss})

    def train(self, minibatch):
        """
        Get minibatch of cases, strip them of their personalities and map. Run fitting on these cases for a single epoch
        :param minibatch: a minibatch of cases on form (x_list, y_list)
        :return: the loss history for plotting
        """
        # seperate x from y
        states, distributions = minibatch

        # on x, state symmetry. On y, action symmetry

        x = []
        y = np.empty(distributions.shape)
        for idx, (state, action_distribution) in enumerate(zip(states, distributions)):
            # NOT LEGAL, but when used for training for OHT, this could significantly reduce time used, but then we
            # need to use "x = states.copy, y= distributions.copy()" and we can use: if state[0] == -1:
            x.append(self.env.state_symmetry(state))
            y[idx] = self.env.action_symmetry(state, atleast_2d(action_distribution))

        x = np.asarray(x)

        history = self.model.fit(x=x, y=y, epochs=1, verbose=0)
        return history


def custom_loss(targets, predictions):
    return tf.reduce_mean(tf.reduce_sum(-1 * targets * tf.math.log(tf.math.maximum(predictions, 0.0001)), axis=[1]))


if __name__ == '__main__':
    net = ActorNetwork([], [], "adam", (16,), 16,"4_10_relu_relu_soft_99" , GameManager(size=4))
