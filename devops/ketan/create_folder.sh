#!/bin/bash

if [ $# -ne 3 ]; then
  echo "Usage: $0 <string> <start_day> <end_day>"
  exit 1
fi

string="$1"
start_day=$2
end_day=$3

if ! [[ "$start_day" =~ ^[0-9]+$ ]] || ! [[ "$end_day" =~ ^[0-9]+$ ]]; then
  echo "Start and end day should be integers."
  exit 1
fi

if [ "$start_day" -gt "$end_day" ]; then
  echo "Start day should be less than or equal to the end day."
  exit 1
fi

for ((i=start_day; i<=end_day; i++)); do
  directory_name="${string}-${i}"
  mkdir "$directory_name"
  echo "Created directory: $directory_name"
done

echo "Directories created successfully."

