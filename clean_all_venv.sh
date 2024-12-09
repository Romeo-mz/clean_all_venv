#! bin/bash
#brew install zenity

directory_clean=$(zenity --file-selection --directory --title="Select a directory where you want to clean all venv")

echo "Cleaning all venv in $directory_clean"

directory_list=$(find $directory_clean -type d -name "venv" -o -name ".venv")

echo "List of venv directories: $directory_list"

for directory in $directory_list;
do  
    read -p "Do you want to create requirements.txt file for this directory : $directory y or n : " yn
    if [ $yn == "y" ]; then
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
    fi
    echo "Done"
    
    read -p "Are you sure to delete this directory : $directory y or n : " yn
    if [ $yn == "y" ]; then
        echo "Deleting $directory"
        rm -rf $directory
    fi
    echo "Done"
done