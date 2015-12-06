cd ../data/
for i in "acc_X" "acc_Y" "acc_Z" "gyro_X" "gyro_Y" "gyro_Z"
do
	echo "$i"
	python prepareDataset.py $i
	gzip -f "$i".pkl
done
