import SdA
import gzip
import cPickle
import numpy as np

folder_name=raw_input()

filenames = ['acc_X', 'acc_Y', 'acc_Z', 'gyro_X', 'gyro_Y', 'gyro_Z']
# filenames = ['acc_X', 'acc_Y']

f = open ("../data/info.txt")
windowoverlaplist  = []
contents = f.read().splitlines()
window=int(contents[1])
overlap=int(contents[3])

hidden = [[int(0.9*window)], [int(0.85*window), int(0.75*window)], [115, 100, 90]]
corrupt = [[0.1], [0.1,0.15], [0.01, 0.02, 0.03]]
pretrain_ep = 10
train_ep = 1

bigmatrix = np.empty(shape=(0,0))
bigtest = np.empty(shape = (0,0))
for nam in filenames:
	name = nam + '.pkl.gz'
	print name
	sda = SdA.train_SdA(dataset=name, hidden_layers_sizes=hidden[1], \
		corruption_levels=corrupt[1], pretraining_epochs=pretrain_ep, training_epochs=train_ep, n_ins=window, n_outs=6)

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

	if nam == filenames[-1]:
		print 'Saving files'

		bigmatrix = np.concatenate((bigmatrix, np.matrix(train_Y).T), axis=1)
		bigtest = np.concatenate((bigtest, np.matrix(test_Y).T), axis=1)
		
		np.savetxt('Ahmed/'+folder_name + '/' + 'training.txt', bigmatrix, delimiter=' ')
		np.savetxt('Ahmed/'+folder_name + '/' + 'test.txt', bigtest, delimiter=' ')

		np.savetxt('Xin/'+folder_name + '/' + 'X_train.txt', bigmatrix[:,:-1], delimiter=' ')
		np.savetxt('Xin/'+folder_name + '/' + 'y_train.txt', test_Y, delimiter=' ')
		np.savetxt('Xin/'+folder_name + '/' + 'X_test.txt', bigtest[:,:-1], delimiter=' ')
		np.savetxt('Xin/'+folder_name + '/' + 'y_test.txt', test_Y, delimiter=' ')

		f=open("Xin/"+folder_name+ '/' + "info1.txt", "w")
		f.write("HiddenLayers Pretraining_Epochs Training_epochs Corruption\n")
		f.write(repr(hidden[1])+' '+ str(pretrain_ep)+" "+str(train_ep)+" "+repr(corrupt[1])+'\n')
		f.write("TrainingDataDim1 TrainingDataDim2 TestDataDim1 TestDataDim2\n")
		f.write(repr(bigmatrix.shape[0]) + ' ' + repr(bigmatrix.shape[1]) + ' ' + repr(bigtest.shape[0]) + ' ' + repr(bigtest.shape[1]) + '\n')

		f.close()

print bigmatrix.shape
print bigtest.shape

