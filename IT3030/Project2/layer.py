from activations import *
from collections import deque


class Layer:
    def __init__(self, in_size, out_size, act: ActivationFunction, weights="Xavier", lr=None):
        self.in_size = in_size
        self.out_size = out_size
        self.activation_function = act
        self.learning_rate = lr

        accepted_weight_inits = ["xavier", "uniform"]
        if weights.lower() == "xavier":
            lim = np.sqrt(6.0) / np.sqrt(self.in_size + self.out_size)
            self.weights = (np.random.rand(self.in_size, self.out_size) * 2 - 1) * lim
        elif weights.lower() == "uniform":
            self.weights = np.random.rand(self.in_size, self.out_size) * 0.2 - 1
        else:
            raise ValueError("Weight initialisation must be of an accepted type: " + str(accepted_weight_inits))

        # self.bias = np.zeros(self.out_size, )
        self.cum_dense_weight_grads = np.zeros(self.weights.shape)

    def reset_on_new_seq(self):
        self.cum_dense_weight_grads = np.zeros(self.weights.shape)
        return True

    def forward_pass(self, layer_input):
        raise NotImplementedError

    def backward_pass(self, layer_input, gradient):
        raise NotImplementedError

    def update_weights(self):
        raise NotImplementedError


class RecurrentLayer(Layer):
    def __init__(self, in_size, out_size, act: ActivationFunction, weights="Xavier"):
        super().__init__(in_size, out_size, act, weights=weights)

        self.context_layer = np.zeros((out_size,))

        if weights.lower() == "xavier":
            lim = np.sqrt(6.0) / np.sqrt(self.out_size + self.out_size)
            self.context_weights = (np.random.rand(self.out_size, self.out_size) * 2 - 1) * lim
        elif weights.lower() == "uniform":
            self.context_weights = np.random.rand(self.out_size, self.out_size) * 0.2 - 1

        self.reserved_jacobian = np.zeros((out_size, ))
        self.cum_rec_weight_gradients = np.zeros((self.out_size, self.out_size))

        self.context_inputs = deque()

    def forward_pass(self, layer_input):


        assert layer_input.shape[-1] == self.in_size

        internal_sum = np.matmul(layer_input, self.weights) + np.matmul(self.context_layer, self.context_weights)

        self.context_inputs.append(self.context_layer)

        layer_output = self.activation_function.forward_pass(internal_sum)
        self.context_layer = layer_output  # TODO: SHOULD context nodes be updated by "activation-ed" values? Yes
        assert layer_output.shape[-1] == self.out_size

        return layer_output

    def backward_pass(self, layer_input, gradient):
        """
        1. get upstream jacobian
        2. gen activations jacobian
        3. gen delta_jacobian(d_l/d_sum) from Upstream dot Act
        4. gen

        :param gradient: loss grad at the previous(in backward terms) layer
        :param layer_input: input coming into this layer, ie the activation of previous(in forward terms) layer
        :return recurrent Jacobian:
        :return neighbor jacobian
        """

        inputs_from_context = self.context_inputs.pop()

        activations_jacobian = self.activation_function.backward_pass(
            np.matmul(layer_input, self.weights) + np.matmul(inputs_from_context, self.context_weights))  # Todo: check

        layer_jacobian = gradient + np.matmul(self.reserved_jacobian, self.context_weights.T) # TODO: c_w may need to be T
        delta_jacobian = np.matmul(activations_jacobian, layer_jacobian)

        self.cum_rec_weight_gradients += np.dot(np.diagflat(delta_jacobian),
                                                np.array([inputs_from_context, ]*self.out_size)).T

        self.cum_dense_weight_grads += np.dot(np.diagflat(delta_jacobian), np.array([layer_input, ]*self.out_size)).T  # This is inefficient. Do not need to extend, rather nx1 and 1xm also works.

        grad_to_pass = np.matmul(delta_jacobian, self.weights.T)
        self.reserved_jacobian = layer_jacobian
        return grad_to_pass

    def update_weights(self):
        self.weights += -self.learning_rate * self.cum_dense_weight_grads
        self.context_weights += -self.learning_rate * self.cum_rec_weight_gradients
        return True

    def reset_on_new_seq(self):
        assert super().reset_on_new_seq()
        self.cum_rec_weight_gradients = np.zeros((self.out_size, self.out_size))
        self.context_layer = np.zeros((self.out_size,))
        self.reserved_jacobian = np.zeros((self.out_size,))
        self.context_inputs.clear()


class DenseLayer(Layer):
    def __init__(self, in_size, out_size, act, weights="Xavier"):
        super().__init__(in_size, out_size, act, weights=weights)

    def forward_pass(self, layer_input):
        assert layer_input.shape[-1] == self.in_size
        layer_output = self.activation_function.forward_pass(np.matmul(layer_input, self.weights))  # No bias nodes.
        assert layer_output.shape[-1] == self.out_size
        return layer_output

    def backward_pass(self, layer_input, gradient):
        activations_jacobian = self.activation_function.backward_pass(np.matmul(layer_input, self.weights))

        layer_jacobian = gradient
        delta_jacobian = np.matmul(activations_jacobian, layer_jacobian)
        J_to_pass_on = np.matmul(delta_jacobian, self.weights.T)

        self.cum_dense_weight_grads += np.dot(np.diagflat(delta_jacobian), np.array([layer_input, ]*self.out_size)).T

        return J_to_pass_on

    def update_weights(self):
        self.weights += -self.learning_rate * self.cum_dense_weight_grads
        return True


def test_layer_forwards():
    inp = np.asarray([1, 0, 0, 1, 0])
    D = DenseLayer(5, 10, Linear())
    out = D.forward_pass(inp)
    print(out)

    print("+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+")

    R = RecurrentLayer(5, 10, Tanh())
    print(R.context_layer)
    print(R.forward_pass(inp)[0])
    print(R.context_layer)
    print(R.forward_pass(inp)[0])
    print(R.context_layer)


if __name__ == '__main__':
    test_layer_forwards()
