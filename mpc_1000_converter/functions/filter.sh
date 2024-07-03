#!/bin/bash

ffprobe_file_info() {
	echo $(ffprobe -v error \
		-select_streams a:0 \
		-show_entries stream=sample_rate,bits_per_sample \
		-of default=noprint_wrappers=1:nokey=1 \
		"$1")
}

# Filter audio files based on specified condition.
# input: audio file(s)
# output: the full path of the audio file(s) that meet the condition
function filter() {
	filename=$(basename "$1")
	extension="${filename##*.}"
	filename="${filename%.*}"

	# Check if the file is a WAV file
	if [[ "$extension" != "wav" ]]; then
		return
	fi

	# Get the sample rate and bit depth of the audio file
	file_info=$(ffprobe_file_info "$1")
	sample_rate=$(echo "$file_info" | awk '{print $1}')
	bits_per_sample=$(echo "$file_info" | awk '{print $2}')

	# Check if
	# - the sample rate is 44100 Hz
	# - the bit depth is 16 bits
	# - the filename is 16 characters or less
	if [[ "$sample_rate" == "44100" && \
		"$bits_per_sample" == "16" && \
		${#filename} -le 16 ]]; then
		return
	fi

	echo "$1"
}

function filter_wrapper() {
	for file in $@; do
		filter "$file"
	done
}
