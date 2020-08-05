"""
keras.py: Solution for keras part of assignment 5
"""

__author__ = "Adrian Langseth"

import pickle
import time
from tensorflow import keras

# import warnings filter
from warnings import simplefilter
# ignore all future warnings
simplefilter(action='ignore', category=FutureWarning)


t0 = time.time()


data = pickle.load(open("keras-data.pickle", "rb"))

# Pulling info
vocab_size = data['vocab_size']
max_length = data['max_length']

# Padding data
padded_x_train = keras.preprocessing.sequence.pad_sequences(data['x_train'], max_length)
padded_x_test = keras.preprocessing.sequence.pad_sequences(data['x_test'], max_length)


# Building model
model = keras.Sequential()
hidden_size = 32


# First Layer
model.add(keras.layers.Embedding(vocab_size, hidden_size, input_length=max_length))


# Last Layers
model.add(keras.layers.LSTM(hidden_size))
model.add(keras.layers.Dense(1))

# Compile Model
model.compile(optimizer='adam', loss='binary_crossentropy', metrics=["accuracy"])
print(model.summary())



# Fitting Model
model.fit(padded_x_train, data['y_train'], epochs=10)


# Evaluating
evaluation = model.evaluate(padded_x_test, data['y_test'], len(padded_x_test))


# output
t1 = time.time()
print("Evaluation score: " + str(evaluation))
print('Time Taken: ' + str(t1 - t0))
