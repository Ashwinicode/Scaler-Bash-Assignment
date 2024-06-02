#!/bin/bash

# Checking if exactly one argument is provided
if [ "$#" -ne 1 ]; then
    echo "Usage of the script: $0 path to Directory"
    exit 1
fi

DIRECTORY="$1"

# Checking if the provided DIRECTORYectory in the argument exists and is readable
if [ ! -d "$DIRECTORY" ]; then
    echo "Error: Directory does not exist or is not readable."
    exit 1
fi

# Declare an associative array to hold file type counts
declare -A file_types

# Traversing the DIRECTORYectory recursively and counting file types based on the extensions(like .sh,.jpg,.pdf,.java,.class etc)
while IFS= read -r -d '' file; do
    file_extension="${file##*.}"
    if [ "$file_extension" != "$file" ]; then
        ((file_types["$file_extension"]++))
    else
        ((file_types["no_file_extension"]++))
    fi
done < <(find "$DIRECTORY" -type f -print0)

# Displaying a sorted list of file types along with their counts
for ext in "${!file_types[@]}"; do
    echo "$ext: ${file_types[$ext]}"
done | sort

exit 0
