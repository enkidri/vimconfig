#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Define file paths and target directory
SOURCE_DIRECTORY=$(dirname "$(realpath "$0")")
TARGET_DIRECTORY=~/.config     # Directory where files will be moved

rm -rf $TARGET_DIRECTORY/nvim
ln -sf "${SOURCE_DIRECTORY}/nvim" $TARGET_DIRECTORY 

echo "Setup completed successfully!"
