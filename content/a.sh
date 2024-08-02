#!/bin/bash

# Define the input folder
input_folder="."

# Iterate through all image files in the input folder
for file in "$input_folder"/*.{jpg,jpeg,png,gif}; do
  # Check if the file exists (in case there are no matching files)
  [ -e "$file" ] || continue

  # Get the file name without the extension
  filename=$(basename -- "$file")
  filename="${filename%.*}"

  # Define the output file name
  output_file="$input_folder/${filename}.webp"

  # Resize and convert the image to WebP format
  convert "$file" -resize 50% "$output_file"
done
