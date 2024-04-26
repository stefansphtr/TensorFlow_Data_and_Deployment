#!/bin/bash

# Find all directories named "data"
find . -type d -name "data" | while read dir; do
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