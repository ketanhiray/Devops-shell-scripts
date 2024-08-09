#!/bin/bash
if [$# -ne 2]; then
        echo "Usage: $0 <source_directory> <target_directory>"
        exit 1
fi

source_dir="$1"
target_dir="$2"

# Validate if the source directory exists
if [ ! -d "$source_dir" ]; then
        echo "Error: Source directory does not exist."
        exit 1

fi

# Validate if the target directory exists
if [! -d "$target_dir" ]; then
        echo "Error: Target directory does not exist."
        exit 1
fi

# Create backup with current time stamp
backup_file="$target_dir/backup_$(date +'%Y%m%d_%H%M%S').tar.gz"

# Create the backup archive
tar -cvf "$backup_file" -C "$source_dir" .

echo "Backup created successfully at : $backup_file"

