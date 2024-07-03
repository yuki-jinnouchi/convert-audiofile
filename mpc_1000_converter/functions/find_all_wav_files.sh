#!/bin/bash

# List all WAV files in a directory
# input: directory
# output: list of all WAV files in the directory
function find_all_wav_files () {
    # check given argument is a directory
    if [ ! -d "$1" ]; then
        echo "Usage: $0 <directory>"
        exit 1
    fi

    # List all WAV files in a directory
    directory="$1"

    find "$directory" -type f -name "*.wav" | sort
}

function list_up_files () {
    files=""
    for file in "$@"; do
        if [ -d "$file" ]; then
            files+="$(find_all_wav_files "$file")"
        elif [ -f "$file" ]; then
            files+="$file"
        else
            echo "Invalid input: $file"
            exit 1
        fi
    done
    echo "$files"
}
