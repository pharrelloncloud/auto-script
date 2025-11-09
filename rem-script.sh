#!/usr/bin/env bash

# This script removes the generated script folder and its contents.

set -euo pipefail

# ask for the folder name to remove

ls -a

read -p "Enter the folder name to remove: " folder_name

if [ -d "$folder_name" ]; then
  rm -rf "$folder_name"
  echo "Removed folder: $folder_name and all its contents."
else
  echo "Folder $folder_name does not exist. Exiting."
  exit 1
fi

echo "Operation completed at $(date +%d-%m-%Y)."

