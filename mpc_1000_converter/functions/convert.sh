#!/bin/bash

# Convert audio files to WAV format with uppercase filenames and a two-digit counter.
# input: audio file(s)
# output: the full path of the converted audio file(s)
function file_converter () {
	# check if the changable variables is set
	if [ -z "${previous_filename+xxx}" ]; then
		previous_filename="-"
	fi

	# check file path and name
	input_file="$1"
	dir="$(dirname "$1")"
	filename=$(basename "$input_file")
	filename="${filename%.*}"

	# set new filename
	new_filename="$(echo "$filename" | \
		tr '[:lower:]' '[:upper:]' | \
		awk '{if (length($0) > 14) \
				print substr($0, 1, 4) substr($0, length($0)-9, 10); \
			else \
				print $0}')"
	# cut -c1-14

	# check if the new filename+counter exist current directory and if find, increment counter
	counter=0
	while [ -f "${dir}/${new_filename}$(printf "%02d" $counter).wav" ]; do
		# find same filename(same new_filename and counter) with find command, increment counter
		counter=$((counter+1))
	done
	# set output filename
	out_filename="${dir}/${new_filename}$(printf "%02d" $counter).wav"

	# convert the audio file
	ffmpeg -loglevel error -i "$input_file" -c:a pcm_s16le "${out_filename}"

	# output the new filename
	echo "${out_filename}"
}

function folder_converter_wrapper() {

	for file in $@; do
		file_converter "$file"
	done
}
