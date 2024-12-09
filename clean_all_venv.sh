#! bin/bash
#brew install zenity

directory_clean=$(zenity --file-selection --directory --title="Select a directory where you want to clean all venv")

directory_list=$(find $directory_clean -type d -name "venv" -o -name ".venv")

echo "List of venv directories: $directory_list"

create_requirements() {
    local directory=$1
    echo "Creating requirements.txt file for $directory"
    site_package_dir=$(find $directory -type d -name "site-packages")

    dist_info_list=$(find $site_package_dir -name "*.dist-info")

    for dist_info in $dist_info_list;
    do 
        metadata_file="$dist_info/METADATA"
        name_info=$(grep -E "^Name: " $metadata_file | awk '{print $2}')
        version_info=$(grep -E "^Version: " $metadata_file | awk '{print $2}')
        echo "$name_info==$version_info" >> $(dirname $directory)/requirements.txt
    done
    echo "Done"
}

delete_directory() {
    local directory=$1
    echo "Deleting $directory"
    rm -rf $directory
    echo "Done"
}

read -p "Do you want confirmation before each action? (y/n): " confirm

for directory in $directory_list;
do  
    if [ "$confirm" == "y" ]; then
        read -p "Do you want to create requirements.txt file for this directory : $directory y or n : " yn
        if [ $yn == "y" ]; then
            create_requirements $directory
        fi
        
        read -p "Are you sure to delete this directory : $directory y or n : " yn
        if [ $yn == "y" ]; then
            delete_directory $directory
        fi
    else
        create_requirements $directory
        delete_directory $directory
    fi
done