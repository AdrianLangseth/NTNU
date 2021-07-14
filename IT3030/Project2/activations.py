from scipy.special import expit, softmax
import numpy as np


class ActivationFunction:
    def __init__(self):
        pass

    def forward_pass(self, input):  # To Be Overridden
        raise NotImplementedError("The layer must be implemented as a specific layer based on its activation function")

    def backward_pass(self, input):  # To Be Overridden
        raise NotImplementedError("The layer must be implemented as a specific layer based on its activation function")


class ReLu(ActivationFunction):
    def forward_pass(self, func_input):
        """
        Runs the forward pass of the activation function
        :param func_input: Input to the activation function
        :return: Returns the maximum of the input and 0.
        """
        return np.maximum(0, func_input)

    def backward_pass(self, func_input):
        """
        Runs the bacward pass of the activation function
        :param func_input: Input to the activation function
        :return: Return the derivative
        """

        r = 1. * (func_input > 0)
        jacobian = np.diagflat(r)
        return jacobian


class Softmax(ActivationFunction):
    def forward_pass(self, func_input):
        """
        Runs the forward pass of the activation function
        :param func_input: Input to the activation function
        :return: Returns the softmax of the input, using the scipy implementation for ease.
        """
        return softmax(func_input, axis=-1)  # Unsure if axis=-1 is correct.

    def backward_pass(self, func_input):
        """
        Runs the bacward pass of the activation function
        :param func_input: Input to the activation function
        :return: Return the derivative
        """
        out = self.forward_pass(func_input)
        helper = np.reshape(out, (-1, 1))
        jacobian = np.diagflat(helper) - np.dot(helper, helper.T)
        return jacobian


class Linear(ActivationFunction):
    """
    Activation function of linear type.
    """

    def forward_pass(self, func_input):
        """
        Runs the forward pass of the activation function
        :param func_input: Input to the activation function
        :return: As it is the linear, the return will be the same as the input
        """
        return func_input

    def backward_pass(self, func_input):  # DIFF
        """
        Runs the jacobian for the bacward pass of the activation function
        :param func_input: Input to the activation function
        :return: Return the jacobian
        """

        return np.eye(len(func_input))


class Sigmoid(ActivationFunction):
    def forward_pass(self, func_input):
        # return 1./(1 + np.exp(-func_input))
        return expit(func_input)

    def backward_pass(self, func_input):
        out = self.forward_pass(func_input=func_input)
        jacobian = np.diagflat(out*(1-out))
        return jacobian


class Tanh(ActivationFunction):
    def forward_pass(self, func_input):
        return np.tanh(func_input)  # Unsure if i can use this. Unsure if axis=-1 is correct.

    def backward_pass(self, func_input):
        out = self.forward_pass(func_input=func_input)
        jacobian = np.diagflat(1-out*out)
        return jacobian


if __name__ == '__main__':
    a = np.asarray([1, 0, 0, 1, 1, 1, 0, 1, 0, 1])
    t = Tanh()
    s = Sigmoid()
    l = Linear()
    sft = Softmax()
    r = ReLu()

    print(t.forward_pass(a))
    print(s.forward_pass(a))
    print(l.forward_pass(a))
    print(sft.forward_pass(a))
    print(r.forward_pass(a))
