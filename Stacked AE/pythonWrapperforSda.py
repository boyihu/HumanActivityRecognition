import SdA
import gzip
import cPickle
import numpy as np

filenames = ['acc_X', 'acc_Y', 'acc_Z', 'gyro_X', 'gyro_Y', 'gyro_Z']
filenames = ['acc_X', 'acc_Y']

f = open ("../data/info.txt")
windowoverlaplist  = []
contents = f.read().splitlines()
window=contents[1]
overlap=contents[1]

hidden = [[110], [110,90], [115, 100, 90]]
corrupt = [[0.1], [0.1,0.15], [0.01, 0.02, 0.03]]

bigmatrix = np.empty(shape=(0,0))
bigtest = np.empty(shape = (0,0))
for nam in filenames:
	name = nam + '.pkl.gz'
	print name
	sda = SdA.train_SdA(dataset=name, hidden_layers_sizes=hidden[0], \
		corruption_levels=corrupt[0], pretraining_epochs=15, training_epochs=1, n_ins=128, n_outs=6)

	f = gzip.open('../data/'+name, 'rb')

	dataset = cPickle.load(f)

	f.close()

	train_X, train_Y = dataset[0]

	test_X, test_Y = dataset[1]

	h_train_X = sda.get_encoding(train_X)
	h_test_X = sda.get_encoding(test_X)

	if(bigmatrix.shape == (0,0)):
		bigmatrix = h_train_X
		bigtest = h_test_X
		continue
	bigmatrix = np.concatenate((bigmatrix, h_train_X), axis=1)
	bigtest = np.concatenate((bigtest, h_test_X), axis=1)

	if name == filenames[-1]:
		bigmatrix = np.concatenate((bigmatrix, train_Y), axis=1)
		bigtest = np.concatenate((bigtest, test_Y), axis=1)

np.savetxt()
print bigmatrix.shape

