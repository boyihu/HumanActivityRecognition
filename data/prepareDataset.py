import cPickle
from scipy.io import loadmat
import numpy as np
from sklearn.cross_validation import train_test_split
import sys

fileName = ['acc_X', 'acc_Y', 'acc_Z', 'gyro_X', 'gyro_Y', 'gyro_Z']
X = []
Y = []

for fName in fileName:
	dataset = loadmat(open(fName+'.mat', 'rb'))

	if(fName != fileName[0]):
		X = np.concatenate((X, dataset.get('X').T), axis=1)

	else:
		X = dataset.get('X').T
		Y = dataset.get('Y')[0]

Y = Y-1	#to ensure class indexes start from 0
X = (X+1)/2

X_train, X_test, y_train, y_test = train_test_split(X, Y, train_size=0.70)

trainset = [X_train, y_train]
validset = [X_test, y_test]
testset = [X_test, y_test]

dataset = [trainset, validset, testset]

f = open('data.pkl', 'wb')
cPickle.dump(dataset, f)
f.close()
