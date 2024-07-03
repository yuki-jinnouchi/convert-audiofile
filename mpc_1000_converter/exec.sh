#!/bin/bash

################ prepare ################
# get directories
PWD=$(pwd)
DIR=$(realpath "$(dirname "$0")")
FUNCTIONS_DIR="${DIR}/functions"

# source all the functions
source "$FUNCTIONS_DIR/filter.sh"
source "$FUNCTIONS_DIR/find_all_wav_files.sh"
source "$FUNCTIONS_DIR/menu.sh"
source "$FUNCTIONS_DIR/convert.sh"
source "$FUNCTIONS_DIR/delete.sh"

# if no input, explain how to use the script
if [ "$#" -eq 0 ]; then
    echo "Usage: $0 <input>"
    echo "  <input> can be one or more files or directory."
    exit 1
fi

################ main ################
echo "Checking files..."
files=$(list_up_files "$@")

# Filter the files using filter.sh
filtered_files=$(filter_wrapper "$files")

# show numbers of files that meet the condition
filtered_count=$(echo "$filtered_files" | sed '/^$/d' | wc -l)

# if no files meet the condition, exit
if [ "$filtered_count" -eq 0 ]; then
    echo "No files meet the condition."
    exit 0
fi

echo "Found $filtered_count files that meet the condition."
echo "$filtered_files"

# ask user if they want to convert the files
menu "Do you want to convert them? [y/n]"
echo "converting..."
folder_converter_wrapper $filtered_files
echo "Convert Done."

# ask user if they want to delete the original files
menu "Do you want to DELETE original files? [y/n]"
echo "deleting..."
delete_files $filtered_files
echo "Delete Done."
