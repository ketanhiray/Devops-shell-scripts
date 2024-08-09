#!/bin/bash
#create a directory
mkdir /home/ubuntu/day11/directory5

if [ $? -ne 0 ]; then
   echo "Error: Directory /home/ubuntu/day11 could not be create.Please check the permissions.!"
   exit 1
fi

#create file inside the directory
touch /home/ubuntu/day11/directory5/task5.txt

if [ $? -ne 0 ]; then
   echo "Error: File /home/ubuntu/day11/directory5/task5.txt could not be created. please check directory is created or not "
   exit 1
fi

echo "Directory and File created Successfully"
