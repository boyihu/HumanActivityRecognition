numdir=`cat project_01/windowandoverlaplist.txt | wc -l`
numdir=1
for ((i=1; i<=$numdir; i++))
do
	echo "Copying Mat files to Data Directory: $i"
	cp project_01/Datasets/$i/* data/

	cd Stacked\ AE/
	sh getDataset.sh
	cd ../
	rm data/*.mat
	cd Stacked\ AE/
	mkdir Ahmed/$i
	mkdir Xin/$i
	python pythonWrapperforSda.py  <<< "1"

	
done

