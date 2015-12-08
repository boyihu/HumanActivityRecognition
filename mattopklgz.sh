#!/bin/bash
numdir=`cat project_01/windowandoverlaplist.txt | wc -l`
#numdir=1
echo $numdir
for ((i=1; i<=$numdir; i++))
do
	echo "Run $i of $numdir..."
	echo "Copying Mat files to Data Directory: $i"
	cp project_01/Datasets/$i/* data/

	cd Stacked\ AE/
	sh getDataset.sh
	cd ../
	rm data/*.mat
	cd Stacked\ AE/
	mkdir Ahmed/$i
	mkdir Xin/$i

	echo "Running Stacked Auto Encoder"
	python pythonWrapperforSda.py  <<< "$i"

	echo "Saving Results to directories"
	cp ../data/info.txt Xin/$i
	cd Xin/$i
	cat info1.txt info.txt > newfile

	rm info1.txt info.txt
	mv newfile info.txt
	cp info.txt ../../Ahmed/$i
	
	cd ../../../

	
done

