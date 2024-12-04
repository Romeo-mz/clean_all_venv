#! bin/bash
#brew install zenity
directory_clean=$(zenity --file-selection --directory --title="Select a directory where you want to clean all venv")

echo "Cleaning all venv in $directory_clean"

