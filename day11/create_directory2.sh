#!/bin/bash

#create a directory

mkdir /home/ubuntu/day11/directory3

if [ $? -ne 0 ]; then 
   echo "Error: Fail to create directory /home/ubuntu/day11"
   exit 1
fi

#create file inside the directory

touch /home/ubuntu/day11/directory3/task2.txt

if [ $? -ne 0 ]; then
   echo "Error: Fail to create file /home/ubuntu/day11/directory3/task2.txt"
   exit 1
fi

echo "Directory and File created Successfully"
