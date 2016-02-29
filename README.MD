## Human Activity Recognition using Smartphone Accelerometer Data

This repository works on Smartphone Accelerometer data using the UCI ML repository data (dataset [here](https://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)).  
Every motion can be classified into a set of 6 actions:
- Walking
- Walking Upstairs
- Walking Downstairs
- Sitting
- Standing
- Laying

We use a Machine Learning approach to solve this classification problem on streams of data. By using a stacked-autoencoder based classification method, we have created a classification schema that is agnostic to the context of the classification problem at hand.
Further description of the dataset can be found [here](https://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones).

#### Stage 1 : Windowing the data
Before the training step of the process, we window the training samples and have a certain degree of samples overlapping across window borders. Sample size and window overlap can be set in project01/windowandoverlap.txt
The directory project_01 has all the codes to solve this section of the problem. Codes are written in MATLAB by a member of my team. 

#### Stage 2 : Training using Stacked Auto-Encoder
In the training phase, we use a stacked auto-encoder to get the training parameters. (stacked autoencoder codes adapted from http://deeplearning.net/tutorial/SdA.html) The number of neural network layers and the layer size can be modified in the Stacked AE codes. 

