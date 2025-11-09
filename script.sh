#!/usr/bin/env bash

# This script takes answers from the command line and writes it into a file in a desired place.

set -euo pipefail

# ask for the folder name (where to save the file)
read -p "Enter the folder name where you want to save the file: " folder_name

if [ -d "$folder_name" ]; then
  echo "Folder $folder_name already exists. Exiting to avoid overwriting."
  exit 1
fi
mkdir -p "$folder_name"
echo "Created folder: $folder_name"

# ask for the script name
read -p "Enter the script name (no .sh): " script_name

if [[ "$script_name" =~ \.sh$ ]]; then
  echo "Please do not include the .sh extension in the script name. Exiting."
  exit 1
fi

# check if the script file already exists in the folder
if [ -f "$folder_name/$script_name.sh" ]; then
  echo "Script $script_name.sh already exists in $folder_name. Exiting to avoid overwriting."
  exit 1
fi

# create the script file inside the folder
script_path="$folder_name/$script_name.sh"
touch "$script_path"

# Make the script executable
chmod +x "$script_path"
echo "Script $script_name.sh created at $folder_name and made executable."

# asks for README.md content
read -p "Enter the content for README.md: " readme_content

# Create README.md file inside the folder
readme_path="$folder_name/README.md"
echo "$readme_content" > "$readme_path"
echo "README.md created at $folder_name with provided content."

# adding a script file to automate pushing to git
cat << 'EOF' > "$folder_name/gitpush.sh"
#!/usr/bin/bash

# check if it is inside a git repository
if [ ! -d ".git" ]; then
  echo "Not inside a git repository. 'git init' first. Exiting."
  exit 1
fi

git add .

read -p "Enter commit message: " commit_message
git commit -m "$commit_message"
git push
EOF
echo "Created gitpush.sh script."

chmod +x "$folder_name/gitpush.sh"
echo "gitpush.sh created at $folder_name and made executable."

echo "All files created successfully in $folder_name at $(date +%d-%m-%Y)."
