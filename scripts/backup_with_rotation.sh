#!/bin/bash

# Display usage information
function display_usage {
    echo "Usage: $0 /path/to/source_directory"
}

# Check if a valid directory path is provided as a command-line argument
if [ $# -eq 0 ] || [ ! -d "$1" ]; then
    echo "Error: Please provide a valid directory path as a command-line argument."
    display_usage
    exit 1
fi

# Assign source directory from command-line argument
source_dir="$1"

# Function to create a timestamped backup and zip it
function create_backup {
    local timestamp=$(date '+%Y-%m-%d_%H-%M-%S')
    local backup_dir="${source_dir}/backup_${timestamp}"

    # Create backup directory and zip its contents
    zip -r "${backup_dir}.zip" "$source_dir" >/dev/null
    if [ $? -eq 0 ]; then
        echo "Backup created successfully: ${backup_dir}.zip"
    else
        echo "Error: Failed to create backup."
    fi
}

# Function to perform rotation and keep only the last 3 backups
function perform_rotation {
    local backups=($(ls -t "${source_dir}/backup_"*.zip 2>/dev/null))

    if [ "${#backups[@]}" -gt 3 ]; then
        local backups_to_remove=("${backups[@]:3}")
        for backup in "${backups_to_remove[@]}"; do
            rm -f "$backup"
        done
    fi
}

# Main script logic
create_backup
perform_rotation
