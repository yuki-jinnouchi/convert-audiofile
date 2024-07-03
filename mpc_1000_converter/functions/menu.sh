#!/bin/bash

function menu() {
    while true; do
        read -rp "$1: " answer
        if [[ $answer == "y" ]]; then
            echo "You entered '$answer'."
            break
        elif [[ $answer == "n" ]]; then
            echo "You entered '$answer'."
            exit 1
        else
            echo "Please enter either 'y' or 'n'."
        fi
    done
}
