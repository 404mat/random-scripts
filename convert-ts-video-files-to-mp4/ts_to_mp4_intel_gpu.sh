#!/bin/bash

# This script converts video files with .ts extension to video
# files in the mp4 format using ffmped. Make sure ffmpeg is installed
# and useable on you computer, and that your gpu drivers are up to date.

# Exit immediately if a command exits with a non-zero status
set -e

# Check if FFmpeg supports Intel QSV
if ! ffmpeg -encoders | grep -q h264_qsv; then
    echo "FFmpeg does not support Intel QSV. Please ensure FFmpeg is built with QSV support."
    exit 1
fi

# Loop through all .ts files in the current directory
for ts_file in *.ts; do
    # Check if any .ts files exist
    if [[ ! -e "$ts_file" ]]; then
        echo "No .ts files found in the current directory."
        exit 1
    fi

    # Extract the base name without extension
    base_name="${ts_file%.ts}"
    
    # Define the output file name
    output_file="${base_name}.mp4"

    # Run FFmpeg with QSV to convert .ts to .mp4
    echo "Converting $ts_file to $output_file using Intel QSV..."
    ffmpeg -i "$ts_file" -c:v h264_qsv -preset fast -c:a aac "$output_file"

    echo "Converted: $output_file"
done

echo "All .ts files have been converted to .mp4 using Intel QSV."
