# convert-audiofile :sound:

## Description
`convert-audiofile` is a shell script that utilizes ffmpeg to convert audio files and rename them.

## Usage
To use `convert-audiofile`, run the following command:
```
sh path/to/the/exec.sh "input_files_or_folder"
```
This program will prompt you twice to confirm if you want to convert and delete the original files.

### Filename Modification
To modify the filename, follow these steps:
1. Take the first 4 characters of the original filename.
2. Take the last 10 characters of the original filename.
3. Append a number followed by the `.wav` extension.

Example:
Original filename: `audiofile1234567890.wav`
Modified filename: `audi9012.wav`

## Requirements
The purpose of `convert-audiofile` is to convert splice files to a format that can be imported into the MPC 1000. The MPC 1000 accepts files that meet the following criteria:
- 16-bit WAV format
- 44.1 kHz sample rate
- Filename length should be less than 16 characters (excluding the extension)

## Implementation
TBD

## Known Bugs
- The script may not function correctly with filenames that contain spaces.
- It may not work properly with input files that have a single dot as the filename.
