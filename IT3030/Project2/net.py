from layer import *
import numpy as np
from numpy import ndarray
from math import isnan


class Network:
    def __init__(self, default_lr=0.1, verbose: bool = False):

        self.layers = []
        self.default_lr = default_lr

        self.verbose = verbose

    # DONE
    def add_layer(self, layer: Layer):
        if layer.learning_rate is None:  # Never actually triggered due to the default value in layer.
            layer.learning_rate = self.default_lr
        self.layers.append(layer)

    # DONE
    def predict(self, sequence):
        inputs = sequence[:-1]
        activation_trace = self.forward_trace(inputs)
        last_activations = [x[-1] for x in activation_trace]  # Todo: Check that this makes sense. Should return the last act of EACH timestep
        return last_activations

    # DONE
    def forward_trace(self, inputs):
        """
        Runs through layers and generates activations.
        :param inputs: inputs to network
        :return: list of activations corresponding to a layers activation.
        """
        activations = []
        for idx, pattern in enumerate(inputs):
            timestep_acts = []
            prev_act = pattern.copy()
            for layer in self.layers:
                prev_act = layer.forward_pass(prev_act)
                timestep_acts.append(prev_act)
            activations.append(timestep_acts)
        return activations

    # TODO: Not Used, Delete
    def train_batch(self, batch, targets):
        """
        Does a forward pass on entire network to gather activations and then runs a bacward pass on all layers.
        :param batch: input batch to model
        :param targets: targets of models
        :return: training loss
        """

        activations = self.forward_trace(batch)
        loss, gradient = self.__calc_loss_grad_loss_regression(activation_output=activations[-1], targets=targets)

        layer_inputs = [batch] + activations[
                                 :-1]  # make list of layer inputs which means all but the last one which is the output

        backwards_layers = reversed(self.layers)
        backwards_layer_input = reversed(layer_inputs)

        for curr_layer, curr_layer_input in zip(backwards_layers, backwards_layer_input):
            gradient = curr_layer.backward_pass(curr_layer_input, gradient)

            loss += curr_layer.regularization()

        if self.verbose:
            print(
                f"network input:\n {np.reshape(batch[0], (int(np.sqrt(len(batch[0]))), int(np.sqrt(len(batch[0])))))}")
            print(f"network ouput: {activations[-1][0]}")
            print(f"target values: {targets[0]}")
            print(f"error/loss: {loss}")
            self.verbose = False
        return loss

    # Done Todo: TEST MODEL
    def train_model(self, sequence, vb):

        inputs = sequence[:-1]
        targets = sequence[1:]

        for layer in self.layers:
            layer.reset_on_new_seq()

        activation_trace = self.forward_trace(inputs)
        last_activations = [x[-1] for x in activation_trace]
        loss, grads = self.loss(last_activations=last_activations, targets=targets)

        backward_layers = reversed(self.layers)
        backward_timesteps = reversed(np.asarray(activation_trace)[:, :-1])

        backward_gradients = reversed(grads)

        for ts, loss_grad, pattern_input in zip(backward_timesteps, backward_gradients, reversed(inputs)):
            gradient = loss_grad
            layer_inputs = [pattern_input]
            layer_inputs.extend(ts)
            layer_inputs = np.asarray(layer_inputs)
            for curr_layer, curr_layer_input in zip(backward_layers, reversed(layer_inputs)):
                assert curr_layer.in_size == curr_layer_input.size
                gradient = curr_layer.backward_pass(curr_layer_input, gradient)

        for layer in self.layers:
            layer.update_weights()

        if self.verbose and vb:
            print(f"\nNetwork Input: {inputs[-1]}")
            print(f"Network Guess: {np.around(last_activations[-1]).astype(int)}")
            print(f"Target Values: {targets[-1]}")
            print(f"mean error/loss for whole sequence: {loss}")
        return loss


    def validation_loss(self, batch, sequence):
        activations = self.forward_trace(batch)
        loss, _ = self.loss(last_activations=activations[-1], sequence=sequence)
        return loss

    # Done
    def loss(self, last_activations, targets):
        """
        Method which calculates loss and loss gradient in respect to the activation output.
        :param last_activations: The last activations in each time K.
        :param sequence: the targets
        :return loss: sum of total losses of all timesteps.
        :return gradients: tensor of loss gradients for each timestep
        """

        last_activations = np.reshape(last_activations, (len(targets), -1))
        error = last_activations[1:] - targets[1:]
        loss = np.mean(np.mean((error) ** 2, axis=1) * 0.5)  # MSE
        gradients = (error) * 2 / 3  # JACOBIAN of MSE function

        return loss, gradients


def test_net():
    net = Network()
    net.add_layer(RecurrentLayer(5, 10, Tanh()))
    net.add_layer(DenseLayer(10, 7, Linear()))
    net.add_layer(RecurrentLayer(7, 5, Tanh()))

    seq = np.asarray([[1, 0, 0, 1, 0], [0, 1, 0, 0, 1], [1, 0, 1, 0, 0], [0, 1, 0, 1, 0]])

    last_activations = net.predict(seq)

    l, g = net.loss(last_activations, seq)

    print(l)
    print(g)


def test_random_shit():
    net = Network()
    net.add_layer(RecurrentLayer(5, 10, Tanh()))
    net.add_layer(DenseLayer(10, 7, Linear()))
    net.add_layer(RecurrentLayer(7, 5, Tanh()))

    seq = np.asarray([[1, 0, 0, 1, 0], [0, 1, 0, 0, 1], [1, 0, 1, 0, 0], [0, 1, 0, 1, 0]])

    out = net.predict(seq)
    print(net.loss(out[-1], seq[-1]))


if __name__ == '__main__':
    test_net()
