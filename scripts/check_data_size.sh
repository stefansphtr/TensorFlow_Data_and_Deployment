#!/bin/bash

# Find all directories named "data"
find . -type d -name "data" | while read dir; do
  # Get size of directory in KB
  dir_size=$(du -sk "$dir" | cut -f1)

  # Check if size is greater than 10MB (10240 KB)
  if [ $dir_size -gt 10240 ]; then
    # Add directory to .gitignore, prepending with "/" to make it relative to the project root
    echo "/${dir#./}" >> .gitignore
  fi
done