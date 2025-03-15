# create directories
mkdir my_directory
mkdir -p /path/to/my_directory          # create a nested directory structure (if it doesn't exist)
mkdir -m 755 my_directory               # create a directory with specific permissions

# remove empty directories
rmdir my_directory
rmdir -p /path/to/empty_directory       # remove a directory and its parent directories if they are empty
