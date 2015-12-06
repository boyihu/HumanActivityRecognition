import SdA
import gzip
import cPickle
import numpy as np

filenames = ['acc_X', 'acc_Y', 'acc_Z', 'gyro_X', 'gyro_Y', 'gyro_Z']
filenames = ['acc_X', 'acc_Y']
for nam in filenames:
	name = nam + '.pkl.gz'
	sda = SdA.train_SdA(dataset=name, hidden_layers_sizes=[100], n_ins=128, n_outs=6, pretraining_epochs=1, training_epochs=2)

	f = gzip.open('../data/'+name, 'rb')

	dataset = cPickle.load(f)

	f.close()

	train_X, train_Y = dataset[0]

	test_X, test_Y = dataset[1]

	h_train_X = sda.get_encoding(train_X)
	print h_train_X