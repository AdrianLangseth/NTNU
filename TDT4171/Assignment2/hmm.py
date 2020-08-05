import numpy as np

def forward(sensor_model, transition_model, message):
    '''
    Forward algorithm
    :param sensor_model: The True/False sensor model as a numpy Matrix
    :param transition_model: The transition model as a numpy Matrix
    :param message: The previous forward message
    :return: The normalized forward message
    '''
    forward_return = sensor_model * transition_model.getT() * message  # Equation 15.12
    return forward_return/forward_return.sum()  # Normalization


def backward(sensor_model, transition_model, message):
    '''
    Backward algorithm
    :param sensor_model: The True/False sensor model as a numpy Matrix
    :param transition_model: The transition model as a numpy Matrix
    :param message: The previous backward message
    :return: The normalized backward message
    '''
    backward_return = transition_model * sensor_model * message # Equation 15.13
    return backward_return/backward_return.sum()  # Normalization


def forward_backward(evidence, prior):
    '''
    Implementation of Forward-Backward algorithm
    :param evidence: The visible states given as an iterable
    :param prior: The initial probability distribution
    :return: The smoothed bacward probabilities
    '''

    # Models
    transition_model = np.matrix([[0.7, 0.3], [0.3, 0.7]])
    sensormodel_true = np.matrix([[0.9, 0.0], [0.0, 0.2]])
    sensormodel_false = np.matrix([[0.1, 0.0], [0.0, 0.8]])

    forward_message = [np.matrix([[0.0], [0.0]]) for i in range((len(evidence) + 1))]
    backward_message = np.matrix([[1.0], [1.0]])


    forward_message[0] = prior
    smoothed_stepvector = [np.matrix([[0.0], [0.0]]) for i in range(len(evidence))]
    t = len(evidence)

    for i in range(1, t + 1):
        if evidence[i-1]:
            forward_message[i] = forward(sensormodel_true, transition_model, forward_message[i - 1])
        else:
            forward_message[i] = forward(sensormodel_false, transition_model, forward_message[i - 1])

    for j in range(t - 1, -1, -1):
        k = forward_message[j].getA()
        l = backward_message.getA()

        step = np.asmatrix(forward_message[j+1].getA() * backward_message.getA())

        smoothed_stepvector[j] = step/step.sum()

        if evidence[j]:
            backward_message = backward(sensormodel_true, transition_model, backward_message)
        else:
            backward_message = backward(sensormodel_false, transition_model, backward_message)
        print(backward_message)
    return smoothed_stepvector


OG_msg = np.matrix([[0.5],[0.5]])
evidence = [True, True, False, True, True]
fm = forward_backward(evidence, OG_msg)
for k, i in enumerate(fm):
    print("b_(" + str(len(evidence) - k) + ':' + str(len(evidence)) + ')', ':', str(i)[1:-1], '\n')