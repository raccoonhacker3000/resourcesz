#!/bin/bash

# Check if directory is provided
if [ -z "$1" ]; then
  echo "Usage: $0 <directory>"
  exit 1
fi

# Directory to search
DIR="$1"

# Recursively process all files
find "$DIR" -type f | while read -r file; do
  sed -i -e 's/\r$//' "$file"
  echo "Processed: $file"
done
