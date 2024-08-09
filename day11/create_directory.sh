#!/bin/bash
#

#Create directory

mkdir /home/ubuntu/day11/directory2

#Check the status

if [ $? -ne 0 ]; then
	echo "Fail to create directory /home/ubuntu/day11/"
else
	echo "Directory created successfully.!!!! "

fi
