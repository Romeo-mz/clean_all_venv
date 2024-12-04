#! bin/bash
#brew install zenity
directory_clean=$(zenity --file-selection --directory --title="Select a directory where you want to clean all venv")

echo "Cleaning all venv in $directory_clean"

directory_list=$(find $directory_clean -type d -name "venv" -o -name ".venv")

echo "List of venv directories: $directory_list"

for directory in $directory_list;
do
    read -p "Are you sure to delete this directory : $directory y or n : " yn
    if [ $yn == "y" ]; then
        echo "Deleting $directory"

    fi
    echo "Not deleting $directory"
done