import cPickle
from scipy.io import loadmat
import numpy as np
from sklearn.cross_validation import train_test_split
import sys

filename = str(sys.argv[1])

dataset = loadmat(open(filename+'.mat', 'rb'))

X = dataset.get('X').T
X = (X+1)/2

Y = dataset.get('Y')[0]
Y = Y-1	#to ensure class indexes start from 0


X_train, X_test, y_train, y_test = train_test_split(X, Y, train_size=0.70)

trainset = [X_train, y_train]
validset = [X_test, y_test]
testset = [X_test, y_test]

dataset = [trainset, validset, testset]

f = open(filename+'.pkl', 'wb')
cPickle.dump(dataset, f)
f.close()
