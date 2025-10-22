#!/bin/bash

source ../../colors.sh


# Ensure two arguments are passed
if [ "$#" -ne 2 ]; then
	echo "Usage: $0 <real_directory> <backup_directory>"
	exit 1
fi

DIR1=$1
DIR2=$2

# Check if both arguments are directories
if [ ! -d "$DIR1" ] || [ ! -d "$DIR2" ]; then
	echo "Both arguments must be directories."
	exit 1
fi

# Normalize paths
DIR1=$(realpath "$DIR1")
DIR2=$(realpath "$DIR2")

# Output files
OUTDIR="./output/$DIR1"
mkdir -p "$OUTDIR"
VERBOSE_DIFF="$OUTDIR/verbose_diff.txt"
DIFF_CONTENTS="$OUTDIR/diff_contents.txt"
ONLY_IN="$OUTDIR/only_in.txt"
PERM_DIFF="$OUTDIR/perm_diff.txt"

# Clear previous outputs
> "$VERBOSE_DIFF"
> "$DIFF_CONTENTS"
> "$ONLY_IN"
> "$PERM_DIFF"

# Compare directories and output differing files/dirs (including hidden files)
diff -qrs "$DIR1" "$DIR2" | while IFS= read -r line; do
	if [[ $line == *"differ"* ]]; then
		file1=$(echo "$line" | awk '{print $2}')
		file2=$(echo "$line" | awk '{print $4}')
		PrintCyan "$file1 differs from $file2"
		diff "$file1" "$file2"
		echo "$file1" >> "$VERBOSE_DIFF"
		diff "$file1" "$file2" >> "$VERBOSE_DIFF"
		echo "$file1" >> "$DIFF_CONTENTS"
		echo ""
	elif [[ $line == *"Only in"* ]]; then
		path=$(echo "$line" | sed -E 's/Only in ([^:]+): (.+)/\1\/\2/')
		PrintLightBlue "$path"
		echo "$path" >> "$ONLY_IN"
		echo ""
	fi
done

PrintLightBlue "Different Permissions"
# Check for permission, ownership, or attribute differences (for files and directories)
find "$DIR1" "$DIR2" -exec stat --format="%n %U %G %A" {} + | sort | while IFS= read -r line; do
	file=$(echo "$line" | awk '{print $1}')
	trimmed_file=$(echo "$file" | sed -e "s|^$DIR2||" | sed -e "s|^$DIR1||")
	if [ -e "$file" ] && [[ ! "$file" =~ "$DIR2" ]]; then
		perm1=$(stat --format="%A" "$DIR1/$trimmed_file" 2>/dev/null)
		perm2=$(stat --format="%A" "$DIR2/$trimmed_file" 2>/dev/null)
		if [ "$perm1" != "$perm2" ]; then
			PrintCyan "$file"
			echo "$file" >> "$PERM_DIFF"
		fi
	fi
done
