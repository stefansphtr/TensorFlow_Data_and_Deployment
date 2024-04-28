#!/bin/bash

# Check if directory argument was provided
if [ $# -eq 0 ]; then
  echo "No directory provided. Usage: ./check_data_size.sh <directory>"
  exit 1
fi

# Define the directory to check
dir_to_check=$1

# Find all directories within the specified directory
find "$dir_to_check" -type d | while read dir; do
  # Get size of directory in KB
  dir_size=$(du -sk "$dir" | cut -f1)

  # Check if size is greater than 10MB (10240 KB)
  if [ $dir_size -gt 10240 ]; then
    # Prepare the path to be added to .gitignore
    ignore_path="/${dir#./}"

    # Check if the path is already in .gitignore
    if ! grep -Fxq "$ignore_path" .gitignore; then
      # If not, add it
      echo "$ignore_path" >> .gitignore
    fi
  fi
done
