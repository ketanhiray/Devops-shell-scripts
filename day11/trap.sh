#!/bin/bash
#
#Create a temp file
temp_file="/home/ubuntu/day11/temp_file_$$.txt"
touch "$temp_file"
echo "Temporary file created at $temp_file"

#set up a trap to delete the temporary file
trap 'echo "Deleting temporary file"; rm -f "$temp_file"' EXIT

#Timer
echo "Script is running...."
sleep 10

#Normal exit
echo "Script completed successfully.....!"

