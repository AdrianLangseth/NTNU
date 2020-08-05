"""
as5.py: Solution for sklearn part of assignment 5
"""


__author__ = "Adrian Langseth"

import pickle
import sklearn.feature_extraction.text as skt
import time
from sklearn.naive_bayes import BernoulliNB
from sklearn.metrics import accuracy_score
from sklearn.tree import DecisionTreeClassifier







t0 = time.time()

k = pickle.load(open("sklearn-data.pickle", "rb"))

vectorizer = skt.HashingVectorizer(stop_words='english', analyzer='word')

xtrain_transformed = vectorizer.fit_transform(k['x_train'])
xtest_transformed = vectorizer.fit_transform(k['x_test'])

# NB classifier part
NBclassifier = BernoulliNB()  # Build Model
NBclassifier.fit(xtrain_transformed, k['y_train'])  # Fitting model
NBpredicted_y = NBclassifier.predict(xtest_transformed)  # Make prediction
NBaccuracy_score = accuracy_score(k['y_test'], NBpredicted_y)  # Evaluate prediction

# Decision Tree part
DTclassifier = DecisionTreeClassifier(max_depth=64, criterion="entropy")  # Create Model
DTclassifier.fit(xtrain_transformed, k['y_train'])  # Fit model
DTpredicted_y = DTclassifier.predict(xtest_transformed)  # Make prediction
DTaccuracy_score = accuracy_score(k['y_test'], DTpredicted_y)  # Evaluate prediction


t1 = time.time()
dt = t1 - t0
print('Time taken:', dt)

# Output
print('BernoulliNB Classifier:', NBaccuracy_score)
print('Desicion Tree Classifier:', DTaccuracy_score)
