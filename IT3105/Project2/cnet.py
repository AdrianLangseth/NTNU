from tensorflow.keras import layers as KL
from tensorflow.keras import activations as KA
from tensorflow.keras import models as KM
from tensorflow.keras import Model
from tensorflow.keras import optimizers as KO
from tensorflow.keras import Sequential
import tensorflow as tf
from numpy import atleast_2d
import numpy as np
from hex_manager import GameManager


class ActorNetwork:
    ACTS = {"linear": KA.linear, "sigmoid": KA.sigmoid, "tanh": KA.tanh, "relu": KA.relu}  # maps the str to the func
    OPTS = {"adam": KO.Adam, "adagrad": KO.Adagrad, "rmsprop": KO.RMSprop, "sgd": KO.SGD}
    LAYERS = {"dense": KL.Dense, "conv": KL.Conv2D, "maxpooling": KL.MaxPooling2D}

    def __init__(self, hidden_layer_sizes, hidden_activations, optimizer: str, input_shape, output_size: int,
                 model_load_path, gm: GameManager, lr=0.01):

        self.minibatch_size = 128
        self.env = gm

        if model_load_path is None:

            input_layer = KL.Input(shape=(self.env.size, self.env.size, 1))
            x = input_layer


            x = KL.Conv2D(filters=32, kernel_size=(3, 3), activation='relu', padding="same")(x)
            x = KL.Conv2D(filters=32, kernel_size=(3, 3), activation='relu')(x)
            x = KL.MaxPooling2D(pool_size=(2, 2), strides=(1, 1))(x)
            # x = KL.Conv2D(filters=32, kernel_size=(3, 3), activation='relu')(x)
            x = KL.Flatten()(x)
            x = KL.Dense(64, activation="relu")(x)
            outputs = KL.Dense(self.env.size ** 2, activation="softmax")(x)

            self.model = Model(inputs=input_layer, outputs=outputs)
            print("Model Generated:")
            self.model.summary()
            self.model.compile(optimizer=KO.Adam(learning_rate=0.001), loss=custom_loss)

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

        inputs = board.reshape((-1, self.env.size, self.env.size, 1))

        predictions = self.model.predict(atleast_2d(inputs))

        assert isinstance(predictions, np.ndarray)

        # invers action symmetry
        action = self.env.action_symmetry(state=state, action=predictions)

        assert isinstance(action, np.ndarray)

        return action

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

        x = np.asarray(x).reshape((-1, self.env.size, self.env.size, 1))

        history = self.model.fit(x=x, y=y, epochs=1, verbose=0)
        return history


def custom_loss(targets, predictions):
    return tf.reduce_mean(tf.reduce_sum(-1 * targets * tf.math.log(tf.math.maximum(predictions, 0.0001)), axis=[1]))
