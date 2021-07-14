import math
import tensorflow as tf
import numpy as np
from collections import defaultdict

# ************** Split Gradient Descent (SplitGD) **********************************
# This "exposes" the gradients during gradient descent by breaking the call to "fit" into two calls: tape.gradient
# and optimizer.apply_gradients.  This enables intermediate modification of the gradients.  You can find many other
# examples of this concept online and in the (excellent) book "Hands-On Machine Learning with Scikit-Learn, Keras,
# and Tensorflow", 2nd edition, (Geron, 2019).

# This class serves as a wrapper around a keras model.  Then, instead of calling keras_model.fit, just call
# SplitGD.fit.
#
# WARNING.  In THEORY, you should be able to use this class by just subclassing it and writing your own code
#  for the "modify_gradients" method.  However, there are many practical issues involving versions of tensorflow, use
# of keras and the tensorflow backend, etc.  So the main purpose of this file is to show the basics of how you can
# split gradient descent into two parts using tf.GradientTape.  Many similar examples exist online, but, again, there
# is no guarantee that they will work seamlessly with your own code.


class SplitGD:

    def __init__(self, keras_model):
        self.model = keras_model
        self.eligibilities = defaultdict(float)

    def modify_gradients(self, gradients, td_error):
        for idx, (weight, gradient) in enumerate(zip(self.model.trainable_weights, gradients)):
            grad_shape = gradient.shape
            self.eligibilities[weight.ref()] += -gradient / td_error  # the 2 is baked into the learning rate.
            gradients[idx] = tf.reshape(- td_error * self.eligibilities[weight.ref()], grad_shape)
        return gradients

    def reset_eligibility(self):
        self.eligibilities.clear()

    def calculate_td_error(self, features, targets):
        predictions = self.model(features)  # Feed-forward pass to produce outputs/predictions
        return targets - predictions.numpy()

    # This returns a tensor of losses, OR the value of the averaged tensor.  Note: use .numpy() to get the
    # value of a tensor.
    def gen_loss(self, features, targets, avg=False):
        predictions = self.model(features)  # Feed-forward pass to produce outputs/predictions
        loss = self.model.loss(targets, predictions)  # model.loss = the loss function
        return tf.reduce_mean(loss).numpy() if avg else loss

    def fit(self, features, targets, epochs=1, mbs=1, vfrac=0.1, verbosity=0, callbacks=None):
        params = self.model.trainable_weights

        train_ins, train_targs, val_ins, val_targs = split_training_data(features, targets, vfrac=vfrac)
        train_targs = np.reshape(train_targs, (-1, 1))
        train_ins = np.reshape(train_ins, (train_targs.shape[0], -1))

        for epoch in range(epochs):
            for _ in range(math.floor(len(train_ins) / mbs)):

                with tf.GradientTape() as tape:  # Read up on tf.GradientTape !!
                    feaset, tarset = gen_random_minibatch(train_ins, train_targs, mbs=mbs)
                    loss = self.gen_loss(feaset, tarset, avg=False)
                    gradients = tape.gradient(loss, params)
                    gradients = self.modify_gradients(gradients, self.calculate_td_error(feaset, tarset))
                    self.model.optimizer.apply_gradients(zip(gradients, params))
            if verbosity > 0:
                self.end_of_epoch_action(train_ins, train_targs, val_ins, val_targs, epoch,
                                         verbosity=verbosity, callbacks=callbacks)

    # The call to model.evaluate does 2 things for a set of features and targets: 1) computes the loss, 2) applies
    # the model's "metric" (which may differ from the loss) to produce an "evaluation".  A typical metrics is
    # "categorical_accuracy" = the fraction of outputs that are "correct", i.e. the highest output neuron
    # corresponds to the correct value.  For more metrics, read up on Keras.metrics.
    # Verbosity levels: 0 = no prints, 1 = only my own prints, 2 = my prints + TF prints (in call to model.evaluate

    def gen_evaluation(self, features, targets, avg=False, verbosity=0, callbacks=None):
        loss, evaluation = self.model.evaluate(features, targets, callbacks=callbacks,
                                               batch_size=len(features), verbose=(1 if verbosity == 2 else 0))
        return evaluation, loss
        # return (tf.reduce_mean(evaluation).numpy() if avg else evaluation), loss

    def status_display(self, val, loss, verbosity=1, mode='Train'):
        if verbosity > 0:
            print('{0} *** Loss: {1} Eval: {2}'.format(mode, loss, val), end=' ')

    def end_of_epoch_action(self, train_ins, train_targs, valid_ins, valid_targs, epoch, verbosity=1, callbacks=None):
        print('\n Epoch: {0}'.format(epoch), end=' ')
        val, loss = self.gen_evaluation(train_ins, train_targs, avg=True, verbosity=verbosity, callbacks=callbacks)
        self.status_display(val, loss, verbosity=verbosity, mode='Train')
        if len(valid_ins) > 0:
            val, loss = self.gen_evaluation(valid_ins, valid_targs, avg=True, verbosity=verbosity, callbacks=callbacks)
            self.status_display(val, loss, verbosity=verbosity, mode='Validation')


# A few useful auxiliary functions

def gen_random_minibatch(inputs, targets, mbs=1):
    indices = np.random.randint(low=0, high=inputs.shape[0], size=mbs)
    return inputs[indices], targets[indices]


# This returns: train_features, train_targets, validation_features, validation_targets
def split_training_data(inputs, targets, vfrac=0.1, mix=True):
    vc = round(vfrac * len(inputs))  # vfrac = validation_fraction
    # pairs = np.array(list(zip(inputs,targets)))
    if vfrac > 0:
        pairs = list(zip(inputs, targets))
        if mix: np.random.shuffle(pairs)
        vcases = pairs[0:vc];
        tcases = pairs[vc:]
        return np.array([tc[0] for tc in tcases]), np.array([tc[1] for tc in tcases]), \
               np.array([vc[0] for vc in vcases]), np.array([vc[1] for vc in vcases])
        #  return tcases[:,0], tcases[:,1], vcases[:,0], vcases[:,1]  # Can't get this to work properly
    else:
        return inputs, targets, [], []


