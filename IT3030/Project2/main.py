from net import *
from data_generator import DataGenerator
from matplotlib import pyplot as plt
from tqdm.contrib.telegram import tqdm
from configparser import ConfigParser
from time import perf_counter

if __name__ == '__main__':
    t0 = perf_counter()

    config_path = 'config2.ini'

    config_object = ConfigParser()
    config_object.read(config_path)

    inputs = config_object["INPUTS"]
    model = config_object["MODEL"]
    general = config_object["GENERAL"]

    # INPUTS
    data_size = int(inputs["data_size_per_pattern"])
    sequence_length = int(inputs["timesteps"])
    input_size = int(inputs["data_length"])
    patterns = tuple(map(int, inputs["patterns"].strip("()").split(', ')))
    test_set_size = int(inputs["test_input_size"])

    # MODEL
    layer_types = tuple(model["layer_types"].strip("()").split(', '))
    nn_activations = tuple(model["nn_activations"].strip("()").split(', '))
    nn_dimensions = tuple(map(int, model["nn_dimensions"].strip("()").split(', ')))
    lr = float(model["learning_rate"])
    weight_init = model["weight_init"]

    verbosity = config_object.getboolean('GENERAL', "verbosity")
    display_images = config_object.getboolean('GENERAL', "display_images")

    if nn_dimensions[-1] != input_size:
        raise ValueError(f"The output of last layer({nn_dimensions[-1]}) must be equal to the input size({input_size})")

    np.random.seed = 420

    Data = DataGenerator(data_length=input_size, sequence_length=sequence_length)

    Net = Network(verbose=verbosity, default_lr=lr)

    last_out = input_size
    for layer_dim, layer_type, activation in zip(nn_dimensions, layer_types, nn_activations):
        if activation.lower() == "relu":
            act = ReLu()
        elif activation.lower() == "linear":
            act = Linear()
        elif activation.lower() == "sigmoid":
            act = Sigmoid()
        elif activation.lower() == "tanh":
            act = Tanh()
        elif activation.lower() == "softmax":
            act = Softmax()
        else:
            raise ValueError(f"Activation \"{activation}\", was not recognised.")

        if layer_type.lower() == "recurrent":
            layer = RecurrentLayer
        elif layer_type.lower() == "dense":
            layer = DenseLayer
        else:
            raise ValueError(f"Layer type \"{layer_type}\", was not recognised.")

        Net.add_layer(layer(last_out, layer_dim, act, weights=weight_init))
        last_out = layer_dim

    losses = []
    i = 0
    print("Fitting data on single epoch ...")
    for sequence in tqdm(Data.generate_data(sequence_amount_per_pattern=data_size, patterns=patterns) , token="", chat_id=''):
        i += 1
        if i % data_size or i == 0:
            this_loss = Net.train_model(sequence, vb=False)
        else:
            this_loss = Net.train_model(sequence, vb=True)

            # outputs = Net.predict(sequence=sequence[:-1])
            # this_loss, _ = Net.loss(outputs, sequence[1:])
            # print(this_loss)
            # print(outputs[-1])
            # guesses = [round(elem) for elem in outputs[-1]]
            # print(np.asarray(guesses))
            # print(sequence[-1])

        losses.append(this_loss)

    if display_images:
        Data.visualize()

    # TESTING
    correct = 0
    total = 0
    for sequence in Data.generate_data(test_set_size, patterns=patterns):
        inputs = sequence[:-1]
        targets = sequence[1:]
        last_acts = Net.predict(sequence=sequence)
        guesses = np.around(last_acts[1:]).astype(int) # For testing we disregard the first as it provides no info on
        # the usage of recurrency.

        correct += np.sum(np.equal(guesses, targets[1:]))
        total += guesses.size

    print(f"accuracy on test set of size {test_set_size}: {np.around(float(correct)/total, 2)}")



    fig, ax = plt.subplots()

    ax.plot([i for i in range(len(losses))], losses, 'k-', label="Mean MSE error",
            linewidth=.25)

    ma = int(data_size*len(patterns)/1000)
    ax.plot([i for i in range(ma - 1, len(losses))],
            np.convolve(losses, np.ones(ma), 'valid') / ma, 'm-', label=f"moving_average({ma})")

    ax.set_ylabel("Sum of MSE")

    fig.suptitle("?")
    ax.set_xlabel("Sequence Number")

    ax.legend(loc="upper left")
    plt.show()

    print(f"{data_size*len(patterns)}: {perf_counter() - t0}")
