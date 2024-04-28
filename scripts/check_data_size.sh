#!/bin/bash

# Check if a directory argument was provided
if [ $# -eq 0 ]; then
  echo "No directory provided. Usage: ./check_data_size.sh <directory>"
  exit 1
fi

# Define the directory to check
directory_to_check=$1

# Find all directories within the specified directory
find "$directory_to_check" -type d | while read -r directory; do
  # Get the size of the directory in KB
  directory_size_kb=$(du -sk "$directory" | cut -f1)

  # Define the size limit in KB (10MB = 10240KB)
  size_limit_kb=10240

  # Check if the directory size is greater than the size limit
  if [ "$directory_size_kb" -gt "$size_limit_kb" ]; then
    # Prepare the path to be added to .gitignore
    gitignore_path="/${directory#./}"

    # Check if the path or any of its parent paths are already in .gitignore
    if ! grep -Fxq "$gitignore_path" .gitignore && ! echo "$gitignore_path" | awk -F/ '{for(i=1;i<=NF;i++)print $i}' | xargs -I {} grep -Fxq "/{}" .gitignore; then
      # If not, add it to .gitignore
      echo "$gitignore_path" >>.gitignore
    fi

    # Print the directory size and path to the console
    echo "$directory_size_kb KB: $directory"
  fi
done

"""
# Check Data Size Script

This script checks the size of all directories within a specified directory and prints the size and path of any directory that exceeds a size limit (10MB in this case). It also adds the path of the oversized directories to the .gitignore file to prevent them from being committed to the repository.

## Usage

Run the script with the directory to check as an argument:

```bash
./check_data_size.sh <directory>
```

## Output

The script prints the size and path of any directory that exceeds the size limit. For example:

```bash
10245 KB: ./large_directory
```

This means that the directory `./large_directory` is 10245 KB, which exceeds the size limit of 10240 KB.

## Error Messages

If you run the script without providing a directory argument, you will see the following error message:

```bash
No directory provided. Usage: ./check_data_size.sh <directory>
```

To resolve this error, provide the directory to check as an argument when running the script.

"""