#!/bin/bash

# Define the output file
OUTPUT_FILE="project_files.txt"

# Define an array of important directories and files to include
FILES_TO_INCLUDE=(
  "app/controllers"
  "app/models"
  "app/views"
  "config/routes.rb"
  "db/migrate"
  "db/seeds.rb"
  "Gemfile"
  "Gemfile.lock"
  "config/database.yml"
)

# Create or empty the output file
> "$OUTPUT_FILE"

# Loop through each file/directory and append its contents to the output file
for ITEM in "${FILES_TO_INCLUDE[@]}"; do
  if [ -d "$ITEM" ]; then
    # If it's a directory, find all files in it
    find "$ITEM" -type f | while read -r FILE; do
      echo "### $FILE ###" >> "$OUTPUT_FILE"
      cat "$FILE" >> "$OUTPUT_FILE"
      echo -e "\n\n" >> "$OUTPUT_FILE"
    done
  elif [ -f "$ITEM" ]; then
    # If it's a file, append its contents
    echo "### $ITEM ###" >> "$OUTPUT_FILE"
    cat "$ITEM" >> "$OUTPUT_FILE"
    echo -e "\n\n" >> "$OUTPUT_FILE"
  fi
done

echo "Project files have been collected into $OUTPUT_FILE"
