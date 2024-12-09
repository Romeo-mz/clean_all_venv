# Cleanup All Venv

A Bash script to clean up Python virtual environments while preserving package information in requirements.txt files.

## Features

- Recursively finds all Python virtual environments (named "venv" or ".venv")
- Creates requirements.txt files before deletion
- Interactive mode with confirmation prompts
- GUI directory selection using zenity

## Requirements

- Bash shell
- zenity (can be installed via `brew install zenity` on macOS)
- Unix-like environment (macOS, Linux)

## Usage

1. Make the script executable: `chmod +x clean_all_venv.sh`
2. Run the script: `bash ./clean_all_venv.sh`

## Author

- Me !
