import numpy as np
from scipy.special import softmax, expit
import unittest as tst
from configparser import ConfigParser
from PIL import Image
from time import perf_counter
from os import mkdir
from sklearn.utils import shuffle
from matplotlib import pyplot as plt



class ActivationFunction:
    def __init__(self):
        pass

    def forward_pass(self, input):  # To Be Overridden
        raise NotImplementedError("The layer must be implemented as a specific layer based on its activation function")

    def backward_pass(self, input):  # To Be Overridden
        raise NotImplementedError("The layer must be implemented as a specific layer based on its activation function")


class DataGenerator:
    def __init__(self, background_dim: int = 26, im_type: list = ["vertical_bar", "horizontal_bar", "rectangle", "cross"], noise=0.01, motif_size: tuple = (20, 20),
                 centering: bool = False, flatten: bool = False, one_hot:bool=True):
        self.supported_types = ["vertical_bar", "horizontal_bar", "rectangle", "cross"]
        assert 10 <= motif_size[0] <= 50
        assert 10 <= motif_size[1] <= 50
        assert background_dim >= motif_size[0]
        assert background_dim >= motif_size[1]
        self.encoding = {"vertical_bar": 0, "horizontal_bar": 1, "rectangle": 2, "cross": 3}
        for i in im_type:
            assert i.lower() in self.supported_types
        self.background_dimensions = (background_dim, background_dim)
        self.image_type = im_type
        assert 0 <= noise <= 1
        self.noise = noise
        self.foreground_dimensions = motif_size
        self.centering = centering
        self.data = {type: [] for type in im_type}  # This is not really used after the load_call

        # will be filled at later time.
        self.train_x = None
        self.train_y = None
        self.validate_x = None
        self.validate_y = None
        self.test_x = None
        self.test_y = None

        self.one_hot = one_hot

        self.flat = flatten

    def generate(self, amount):
        for type in self.image_type:
            for i in range(amount):
                max_x = self.background_dimensions[0] - self.foreground_dimensions[0]
                max_y = self.background_dimensions[1] - self.foreground_dimensions[1]

                start_x = np.random.randint(max_x + 1)
                start_y = np.random.randint(max_y + 1)

                # empty background
                d = np.zeros(self.background_dimensions)

                # draw Picture
                if type == "horizontal_bar":
                    for i in range(start_y, start_y + self.foreground_dimensions[1], 2):
                        d[i, start_x:start_x + self.foreground_dimensions[0]] = 1

                elif type == "vertical_bar":
                    for i in range(start_x, start_x + self.foreground_dimensions[0], 2):
                        d[start_y: start_y + self.foreground_dimensions[1], i] = 1

                elif type == "cross":
                    mid_x = start_x + self.foreground_dimensions[0] // 2
                    mid_y = start_y + self.foreground_dimensions[1] // 2
                    d[mid_y, start_x:start_x + self.foreground_dimensions[0]] = 1
                    d[start_y: start_y + self.foreground_dimensions[1], mid_x] = 1

                elif type == "rectangle":
                    d[start_x:start_x + self.foreground_dimensions[0] - 1, start_y] = 1
                    d[start_x:start_x + self.foreground_dimensions[0], start_y + self.foreground_dimensions[1] - 1] = 1
                    d[start_x, start_y:start_y + self.foreground_dimensions[1] - 1] = 1
                    d[start_x + self.foreground_dimensions[0] - 1, start_y:start_y + self.foreground_dimensions[1]] = 1
                else:
                    raise TypeError("Unknown Type, given type not in " + str(self.supported_types))

                # add noise
                noise = np.random.choice(2, size=self.background_dimensions, p=[1 - self.noise, self.noise])
                d = np.mod(d + noise, 2)

                d = d.flatten()

                self.data[type].append(d)

    def store(self, suffix: str = "_small.csv", fp: str = "DATA/", training_size=0.7, validation_size=0.2,
              test_size=0.1):
        assert round(training_size + validation_size + test_size, 4) == 1
        d = {"train_X": [], "validate_X": [], "test_X": [], "train_Y": [], "validate_Y": [], "test_Y": []}
        for im_type in self.data:
            #train set
            train_bound = int(len(self.data[im_type]) * training_size)
            d["train_X"].extend(self.data[im_type][0:train_bound])
            d["train_Y"].extend([self.encoding[im_type] for i in range(train_bound)])
            # validation set
            validation_bound = int(len(self.data[im_type]) * (training_size + validation_size))
            d["validate_X"].extend(self.data[im_type][train_bound:validation_bound])
            d["validate_Y"].extend([self.encoding[im_type] for i in range(validation_bound - train_bound)])
            # test set
            d["test_X"].extend(self.data[im_type][validation_bound:])
            d["test_Y"].extend([self.encoding[im_type] for i in range(len(self.data[im_type]) - validation_bound)])

        for key in d:
            try:
                np.savetxt(fp + key + suffix, d[key], delimiter=",") # it complains im giving it a list but it works so_
            except FileNotFoundError:
                mkdir(fp)
                np.savetxt(fp + key + suffix, d[key], delimiter=",")

    def load(self, fp_train_X: str, fp_train_Y: str, fp_validate_X: str, fp_validate_Y: str, fp_test_X: str,
             fp_test_Y: str, directory: str = "DATA/"):
        x = np.loadtxt(directory + fp_train_X, delimiter=",")
        y = np.loadtxt(directory + fp_train_Y, delimiter=",")
        self.train_x, self.train_y = shuffle(x, y)
        x = np.loadtxt(directory + fp_validate_X, delimiter=",")
        y = np.loadtxt(directory + fp_validate_Y, delimiter=",")
        self.validate_x, self.validate_y = shuffle(x, y)
        x = np.loadtxt(directory + fp_test_X, delimiter=",")
        y = np.loadtxt(directory + fp_test_Y, delimiter=",")
        self.test_x, self.test_y = shuffle(x, y)

        if not self.flat:
            self.train_x = np.reshape(self.train_x, (self.train_x.shape[0], *self.background_dimensions))
            self.validate_x = np.reshape(self.validate_x, (self.validate_x.shape[0], *self.background_dimensions))
            self.test_x = np.reshape(self.test_x, (self.test_x.shape[0], *self.background_dimensions))

        if self.one_hot:
            y = np.zeros((self.train_y.size, 4))
            y[np.arange(self.train_y.size), self.train_y.astype(int)] = 1.0
            self.train_y = y

            y = np.zeros((self.validate_y.size, 4))
            y[np.arange(self.validate_y.size), self.validate_y.astype(int)] = 1
            self.validate_y = y

            y = np.zeros((self.test_y.size, 4))
            y[np.arange(self.test_y.size), self.test_y.astype(int)] = 1
            self.test_y = y

    def get_all_images_as_array(self, flatten: bool = True):
        """
        Unecessary method left for future implementation if necessary
        :param flatten:
        :return:
        """
        pass

    def get_batch(self, x_array, y_array, batch_size=1000):
        """
        Generator for batches
        :param x_array: array of images to be batched
        :param y_array: array of targets
        :param batch_size: size of each batch
        :return: Continuously yields batches of given size.
        :returnType: [x,y] x: batchsize amount of arrays in a list, y: batchsize amount of target values
        """

        if self.train_x is None or self.train_y is None:
            raise ValueError("Must load data before batches can be produced")
        if len(self.train_x) != len(self.train_y):
            raise ValueError("values and target should be of equal amounts.")

        point = 0
        while True:
            batch = []
            if point + batch_size > len(y_array):
                of = point + batch_size - len(y_array)
                batch.append(np.concatenate((x_array[point:], x_array[:of])))
                batch.append(np.concatenate((y_array[point:], y_array[:of])))
                point = of
            else:
                batch.append(x_array[point:point + batch_size])
                batch.append(y_array[point:point + batch_size])
                point += batch_size
            yield batch

    def get_train(self):
        return self.train_x, self.train_y

    def get_validate(self):
        return self.validate_x, self.validate_y

    def get_test(self):
        return self.test_x, self.test_y

    def visualize_images(self, amount, im_type:str) -> bool:
        """

        :param amount: amount of images to be visualized
        :param im_type: Requested image type
        :return: bool indicating wether requested amount was visualized.
        """
        if self.flat:
            train = np.reshape(self.train_x, (self.train_x.shape[0], *self.background_dimensions))
        else:
            train = self.train_x

        if self.one_hot:
            x = np.argmax(self.train_y, axis=1)
        else:
            x = self.train_y


        indices = [idx for idx, type in enumerate(x) if type == self.encoding[im_type]]
        for count, index in enumerate(indices):
            if count == amount:
                return True
            img = Image.fromarray(train[index]*255.0)
            img.show()
        return False


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
        jacobian = np.empty((func_input.shape[0], func_input.shape[1], func_input.shape[1]))

        for idx, case in enumerate(r):
            jacobian[idx, :, :] = np.diagflat(case)
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
        jacobian = np.empty((func_input.shape[0], func_input.shape[1], func_input.shape[1]))
        out = self.forward_pass(func_input)
        for idx, case in enumerate(out):
            helper = np.reshape(case, (-1, 1))
            jacobian[idx, :, :] = np.diagflat(helper) - np.dot(helper, helper.T)
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

        return np.asarray([np.eye(func_input.shape[1]) for _ in range(func_input.shape[0])])


class Sigmoid(ActivationFunction):
    def forward_pass(self, func_input):
        # return 1./(1 + np.exp(-func_input))
        return expit(func_input)

    def backward_pass(self, func_input):
        jacobian = np.empty((func_input.shape[0], func_input.shape[1], func_input.shape[1]))
        out = self.forward_pass(func_input=func_input)
        for idx, case in enumerate(out):
            jacobian[idx, :, :] = np.diagflat(case * (1 - case))
        return jacobian


class Tanh(ActivationFunction):
    def forward_pass(self, func_input):
        return np.tanh(func_input)  # Unsure if i can use this. Unsure if axis=-1 is correct.

    def backward_pass(self, func_input):
        jacobian = np.empty((func_input.shape[0], func_input.shape[1], func_input.shape[1]))
        out = self.forward_pass(func_input=func_input)
        for idx, case in enumerate(out):
            jacobian[idx, :, :] = np.diagflat(1 - case * case)
        return jacobian


class Layer:
    """
    Main thing, starts with outputs of previous layer, incorporates incoming weights as part of layer, but not outgoing weights.
    """
    def __init__(self, in_size: int, out_size: int, activation_function: ActivationFunction, lr=None,
                 weights="Xavier"):
        self.in_size = in_size
        self.out_size = out_size

        accepted_weight_inits = ["xavier", "uniform"]
        if weights.lower() == "xavier":
            lim = np.sqrt(6.0) / np.sqrt(self.in_size + self.out_size)
            self.weights = (np.random.rand(self.in_size, self.out_size) * 2 - 1) * lim
        elif weights.lower() == "uniform":
            self.weights = np.random.rand(self.in_size, self.out_size) * 0.2 - 1
        else:
            raise ValueError("Weight initialisation must be of an accepted type: " + str(accepted_weight_inits))

        self.activation_function = activation_function
        self.learning_rate = lr

        self.loss_reg = None
        self.reg_const = 0

        # initialize biases at zero
        self.bias = np.zeros(self.out_size, )

        pass

    def forward_pass(self, layer_input):
        assert layer_input.shape[-1] == self.in_size
        layer_output = self.activation_function.forward_pass(np.matmul(layer_input, self.weights) + self.bias)
        assert layer_output.shape[-1] == self.out_size
        return layer_output

    def l1_regularization(self):
        """
        calculates l1 regularization
        :return: l1 regularization for this layer
        """
        return np.sum(np.abs(self.bias)) + np.sum(np.sum(np.abs(self.weights)))

    def l2_regularization(self):
        """
        calculates l2 regularization
        :return: l2 regularization for this layer
        """
        return (np.sum(self.bias ** 2) + np.sum(np.sum(self.weights ** 2)))/2

    def regularization(self):
        """
        returns the appropriate reqularization. Eases complexity of Network class
        :return:
        """
        if self.loss_reg == "L1":
            return self.l1_regularization()*self.reg_const
        elif self.loss_reg == "L2":
            return self.l2_regularization()*self.reg_const
        elif self.loss_reg is None:
            return 0

    def regularization_derivative(self):
        """
        returns the appropriate reqularization. Eases complexity of Network class
        :return: w, b
        """
        if self.loss_reg == "L1":
            return np.sign(self.weights) * self.reg_const, np.sign(self.bias) * self.reg_const
        elif self.loss_reg == "L2":
            return self.weights * self.reg_const, self.bias * self.reg_const
        elif self.loss_reg is None:
            return 0, 0

    def backward_pass(self, layer_input, gradient):
        """
        Should update weights, biases and return loss_gradient to the next(in backwards terms) layer
        :param gradient(jacobian): loss grad at the previous(in backward terms) layer
        :param layer_input: input coming into this layer, ie the activation of previous(in forward terms) layer
        :return: loss-gradient from L to this layer J_(input to layer)^Loss
        """


        # ASSERTIONS
        assert layer_input.shape[-1] == self.in_size
        assert gradient.shape[-1] == self.out_size

        # JACOBIAN OF ACTIVATION FUNCTION: (output_dim, output_dim), d(transfer) / d(kernel)
        activations_jacobian = self.activation_function.backward_pass(np.matmul(layer_input, self.weights) + self.bias)

        # param gradient is d(loss) / d (act)
        # activations_jacobian is d(act) / d(kernel)
        # d loss / d transfer * d transfer/ d kernel resulting in a matrix of size [batch_size, output_size]

        J_loss_to_sum = np.empty_like(gradient)
        for idx in range(gradient.shape[0]):
            J_loss_to_sum[idx, :] = np.matmul(activations_jacobian[idx, :, :], gradient[idx, :])

        # Calculate d Loss / d input. Diff from J_loss_to_weights is that this is past weights. immediately after output from previous layer
        Jacobian_to_pass_on = np.matmul(J_loss_to_sum, self.weights.T)

        weight_gradients = np.matmul(layer_input.T, J_loss_to_sum)/layer_input.shape[0] # Should this be divided by input.shape[0]?
        bias_gradients = np.sum(J_loss_to_sum, axis=0)/layer_input.shape[0]

        # Add contribution from loss regularizer
        w, b = self.regularization_derivative()
        weight_gradients += w
        bias_gradients += b

        #Update weights and biases
        self.weights += -self.learning_rate * weight_gradients
        self.bias += -self.learning_rate * bias_gradients

        return Jacobian_to_pass_on


class Network:
    def __init__(self, model_type:str=None, default_lr=0.01, loss_reg=None, reg_constant=0.01, verbose:bool=False):

        self.layers = []
        self.model_type = model_type.lower()
        self.default_lr = default_lr
        self.reg_constant = reg_constant
        self.reg_mode = None

        self.verbose = verbose

        if self.model_type == "regression":
            self.loss_and_gradient_func = self.__calc_loss_grad_loss_regression  # MSE
        elif self.model_type== "classification":
            self.loss_and_gradient_func = self.__calc_loss_grad_loss_classification  # Cross-Entropy
        else:
            raise ValueError(f"Model type must be either \"regression\", \"classification\". {model_type} was not accepted.")



        if loss_reg.lower() == "L1".lower():
            self.reg_mode = "L2"
        elif loss_reg.lower() == "L2".lower():
            self.reg_mode = "L1"
        elif loss_reg == None:
            self.reg_constant = 0
        else:
            raise ValueError(
                f"default_loss_reg must be either \"L1\", \"L2\" or \"NONE\". {model_type} was not accepted.")

    def add_layer(self, layer: Layer):
        if layer.learning_rate is None: # Never actually triggered due to the default value in layer.
            layer.learning_rate = self.default_lr
        self.layers.append(layer)
        layer.reg = self.reg_mode
        layer.reg_constant = self.reg_constant

    def predict(self, input):
        activation_trace = self.forward_trace(input)
        last_activation = activation_trace[-1]
        if self.model_type == "regression":
            return np.argmax(last_activation, axis= -1)
        elif self.model_type == "classification":
            return np.argmax(last_activation, axis= -1)
        else:
            raise ValueError("The model must be regression or Classification")

    def forward_trace(self, input):
        """
        Runs through layers and generates activations.
        :param input: inputs to network
        :return: list of activations corresponding to a layers activation.
        """
        activations = []
        last_activation = input.copy()
        for layer in self.layers: # Todo: Dette ble noe søl, fiks om ikke funker, ellers bare rydd om mer tid.
            last_activation = layer.forward_pass(last_activation).copy()
            activations.append(last_activation)
        return activations

    def train_batch(self, batch, targets):
        """
        Does a forward pass on entire network to gather activations and then runs a bacward pass on all layers.
        :param batch: input batch to model
        :param targets: targets of models
        :return: training loss
        """

        activations = self.forward_trace(batch)
        loss, gradient = self.loss_and_gradient_func(activation_output=activations[-1], targets=targets)

        layer_inputs = [batch] + activations[:-1] # make list of layer inputs which means all but the last one which is the output

        backwards_layers = reversed(self.layers)
        backwards_layer_input = reversed(layer_inputs)

        for curr_layer, curr_layer_input in zip(backwards_layers, backwards_layer_input):

            gradient = curr_layer.backward_pass(curr_layer_input, gradient)

            loss += curr_layer.regularization()


        if self.verbose:
            print(f"network input:\n {np.reshape(batch[0], (int(np.sqrt(len(batch[0]))), int(np.sqrt(len(batch[0])))))}")
            print(f"network ouput: {activations[-1][0]}")
            print(f"target values: {targets[0]}")
            print(f"error/loss: {loss}")
            self.verbose = False
        return loss

    def validation_loss(self, batch, targets):
        activations = self.forward_trace(batch)
        loss, _ = self.loss_and_gradient_func(activation_output=activations[-1], targets=targets)
        return loss


    def __calc_loss_grad_loss_classification(self, activation_output, targets):  # ToDo: Change from classification-based to Categorical Cross-entropy
        """
        Calculate loss and loss-gradient for classification.
        :param activation_output: output of last activation function, probably softmax. The output are probabilities-ish
            shape: (batch_size, no_classes)
        :param targets: One-hots of the correct classes.
            shape: (batch_size, no_classes)
        :return train_loss: cross-entropy loss over batch
        :return loss_grad: cross-entropy loss gradient over batch
        """
        # assert np.all(activation_output.shape == targets.shape)
        batch_size, class_count = activation_output.shape # not really necessary but i'm not brave enough to delete on demo day.

        epsilon = 0.000000001  # small increase to avoid infinites.
        log_likelihood = np.log(activation_output[np.where(targets)] + epsilon)
        loss = -np.mean(log_likelihood)

        gradient = -(1) * (targets / (activation_output + epsilon))

        return loss, gradient

    #Should be static
    def __calc_loss_grad_loss_regression(self, activation_output, targets):
        """
        Calculate loss and loss-gradient for regression.
        :param activation_output: output of last activation function.
            shape: (batch_size, no_classes)
        :param targets: target values of the classes.
            shape: (batch_size, no_classes)
        :return train_loss: MSE loss over batch
        :return loss_grad: MSE loss gradient over batch
        """

        # Calculation
        loss = np.mean((activation_output - targets)**2)*0.5  # MSE
        gradient = (activation_output - targets)*2/3  # JACOBIAN of MSE function

        return loss, gradient

def l(fp:str="./config.txt"):
    # INIT
    cp = ConfigParser()
    cp.read(fp)

    np.random.seed(cp.getint('HYPER', 'random_seed', fallback=420))

    #DATA
    train_x_file = cp.get('DATA', 'train_x')
    train_y_file = cp.get('DATA', 'train_y')
    validate_x_file = cp.get('DATA', 'validate_x')
    validate_y_file = cp.get('DATA', 'validate_y')
    test_x_file = cp.get('DATA', 'test_x')
    test_y_file = cp.get('DATA', 'test_y')

    data_directory = cp.get('DATA', 'directory')
    data_suffix = cp.get('DATA', 'suffix')


    # LAYERS
    sizes_as_string = cp.get("MODEL", "layers", fallback="0").split(",")
    layer_sizes = tuple([int(layer_size) for layer_size in sizes_as_string])
    activation_functions = cp.get("MODEL", "activations", fallback="").split(",")

    initial_weights = cp.get("MODEL", "weight_init", fallback="Xavier")

    # Loss
    model_type = cp.get("MODEL", "model_type", fallback="classification")

    default_learning_rate = cp.getfloat("HYPER", "learning_rate")
    batch_count = cp.getint("HYPER", "batches")
    regularization = cp.get("HYPER", "regularizer")
    reg_const = cp.getfloat("HYPER", "regularization_constant")

    gen_data = cp.getint('DATA', 'gen_data')

    background_dims = cp.getint('DATA', 'background_dims')
    data_size = cp.getint('DATA', 'datasize')
    data_types = cp.get('DATA', 'image_types', fallback="vertical_bar, horizontal_bar, rectangle, cross").split(",")
    motif_dims_as_string = cp.get("DATA", "motif_dims", fallback="10,10").split(",")
    motif_dims = tuple([int(dim) for dim in motif_dims_as_string])
    flatten = cp.getboolean('DATA', 'flatten')
    noise = cp.getfloat("DATA", "noise")
    onehot = True
    visualize_data = cp.getint("DISPLAY", "display_images", fallback=0)
    vis_data_type = cp.get("DISPLAY", 'visualize_type', fallback=data_types[0])

    verbose = cp.getboolean('DISPLAY', 'verbose')

    Data_gen = DataGenerator(im_type=data_types, motif_size=motif_dims,
                      background_dim=background_dims, flatten=flatten, noise=noise, one_hot=onehot)

    # If we are told to generate data, we generate data, either way we load the data
    if cp.getint('DATA', 'gen_data'):
        Data_gen.generate(data_size)
        Data_gen.store(data_suffix, data_directory)
    Data_gen.load(train_x_file, train_y_file, validate_x_file, validate_y_file, test_x_file, test_y_file, directory=data_directory)

    # If we wish to visualize data, we do so through the Data_gen the correct amount.
    if visualize_data:
        Data_gen.visualize_images(visualize_data, vis_data_type)

    # Create a network object, iterate through activations and layer sizes and add to the network
    net = Network(model_type=model_type, default_lr=default_learning_rate, loss_reg=regularization, reg_constant=reg_const, verbose=verbose)
    previous_size = background_dims**2
    for size, activation in zip(layer_sizes, activation_functions):
        if size > 0:
            if activation.strip().lower() == "relu":
                func = ReLu()
            elif activation.strip().lower() == "linear":
                func = Linear()
            elif activation.strip().lower() == "tanh":
                func = Tanh()
            elif activation.strip().lower() == "sigmoid":
                func = Sigmoid()
            elif activation.strip().lower() == "softmax":
                func = Softmax()
            else:
                raise ValueError(f"Unknown activation: {activation}")
            print(f"Adding layer from {previous_size:8d} to {size:8d} dims using {activation.strip().lower()}")
            net.add_layer(layer=Layer(previous_size, size, activation_function=func, weights=initial_weights))
            previous_size = size
        else:
            print("Size == 0, so this layer will not be added...")

    # train_period with validation also.
    best_loss = np.inf
    losses = []
    validation_losses = []
    validation_loss_indices = []
    for batch_idx, [x_batch, y_batch] in enumerate(Data_gen.get_batch(*Data_gen.get_train(), 100)):
        this_loss = net.train_batch(x_batch, y_batch)
        if this_loss < best_loss:
            best_loss = this_loss
        losses.append(this_loss)
        if batch_idx % 10 == 0:
            print(f"{batch_idx:6d}: Batch loss {this_loss:8.4f}")
            x_valid, y_valid = Data_gen.get_validate()
            targets = np.argmax(y_valid, axis=1)
            val_loss = net.validation_loss(x_valid, y_valid)
            validation_losses.append(val_loss)
            validation_loss_indices.append(batch_idx)
            # if val_loss > validation_losses[-5]: # Rudimentary Early Stopping
                # break
        if batch_idx % 1000 == 0:
            print(net.layers[0].weights)
        if batch_idx > batch_count:
            break

    # Get test values and run testing.
    x_test, y_test = Data_gen.get_test()
    predictions = net.predict(x_test)
    targets = np.argmax(y_test, axis=1)
    print(f"Accuracy on test-set: {100 * np.average(predictions == targets):.2f}%")
    print(np.unique(predictions, return_counts=True))
    print(np.unique(targets, return_counts=True))

    # print(net.layers[0].weights)

    # Plot the stats
    loss_string = "Cross Entropy" if model_type == "classification" else "MSE"
    plt.plot([i for i in range(len(losses))], losses, label="Training Loss (with regularizer)")
    plt.plot(validation_loss_indices, validation_losses, label="Validation Loss (w/o regularizer)")
    plt.title(f"{loss_string} Loss")
    plt.legend(loc="upper left")
    plt.xlabel("Batch Number")
    plt.ylabel("Loss")
    plt.show()

if __name__ == '__main__':
    t0 = perf_counter()
    l("config.txt")
    print("+------------------------------+")
    print(f"Time taken: {perf_counter() - t0} seconds.")
