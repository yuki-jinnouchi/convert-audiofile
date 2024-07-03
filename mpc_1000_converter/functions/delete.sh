#!/bin/bash

# Delete files passed as arguments
delete_files() {
    for file in $@ ; do
        if [ -f "$file" ]; then
            mv "$file" ~/.Trash
            echo "Deleted $file"
        else
            echo "File $file does not exist"
        fi
    done
}
