#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Define file paths and target directory
DIR_TO_MOVE=("coc" "nvim") # List of files to move
TARGET_DIRECTORY=~/.config     # Directory where files will be moved

# Define the program to install
PROGRAM="clangd"

PWD=$(dirname "$(realpath "$0")")

# Ensure the target directory exists
echo "Ensuring target directory exists..."
if [ ! -d "$TARGET_DIRECTORY" ]; then
  mkdir -p "$TARGET_DIRECTORY"  # Use sudo to create the directory if it doesn't exist
  echo "Created target directory: $TARGET_DIRECTORY"
else
  echo "Target directory already exists: $TARGET_DIRECTORY"
fi

# Move files
echo "Moving files..."
for DIR in "${DIR_TO_MOVE[@]}"; do
  DIR_ABS="$PWD/$DIR"	# Resolve relative path to absolute
  if [ -d "$DIR_ABS" ]; then
    cp -r "$DIR" "$TARGET_DIRECTORY"  # Request sudo only when needed
    echo "Moved $DIR to $TARGET_DIRECTORY"
  else
    echo "File $DIR does not exist. Skipping."
  fi
done

# Update package list and install program
echo "Updating package list and installing $PROGRAM..."
sudo apt update  # Requests sudo for updating packages
sudo apt install "$PROGRAM"  # Requests sudo for installing the program
curl -sL install-node.vercel.app/lts | sudo bash  # Updates nodejs so that coc.vim works 

echo "Setup completed successfully!"

