
find     # search for files and directories in a directory hierarchy
-exec    # uses the result of find to do something

find /path -name "file.txt"      # find files named "file.txt"
find /path -iname "file.txt"     # find files named "file.txt", case-insensitive
find /path -name "*.jpg"

find /path -type f               # find all regular files
find /path -type d               # directories
find /path -type l               # symbolic links

find /path -size +10M            # files larger than 10 MB
find /path -size -500k           # smaller than 500 KB
find /path -size 100k            # exactly 100 KB in size
find / -type f -size +100M -exec ls -lh {} + | sort -k5 -h  # Find files larger than 100MB and sort by size

find /path -perm 644             # with permissions 644
find /path -perm /u+x            # executable by the user
find /path -perm -u=rwx          # at least rwx permissions for the user

find /path -mtime -7             # find files modified in the last 7 days
find /path -mtime +30            # modified more than 30 days ago
find /path -mmin -1              # modified in the last minute
find /path -mtime 0              # in last 24 Hours
find /path -cmin 5               # files that have their metadata changed exactly 5 minutes ago

find /path -atime -5             # find files accessed in the last 5 days
find /path -atime +10            # find files accessed more than 10 days ago

find /path -ctime -3             # find files where metadata changed in the last 3 days
find /path -ctime +15            # find files where metadata changed more than 15 days ago

find /path -name "*.log" -exec rm {} \;    # find and delete all .log files ( {} is substitute of find results, ; is escaped so it gets interpreted by find not by bash shell )
find /path -type f -exec chmod 644 {} \;   # find all files and change permissions to 644
find /path -type d -exec chmod 755 {} \;   # find all directories and change permissions to 755

# Search and Print file Details
find /path -name "*.txt" -ls              # find .txt files and display detailed information

# Search by User or Group
find /path -user username                 # find files owned by a specific user
find /path -group groupname               # find files belonging to a specific group

# AND / OR / NOT
find /path -type f -name "*.txt" -size +1M               # find .txt files larger than 1 MB
find /path -type f \( -name "*.jpg" -o -name "*.png" \)  # find files with .jpg or .png extensions (escaping so it gets interpreted by find not bash)
find /path \! -user owner     # show all files not owner by user 'owner'

find /path -name "*.tmp" -delete          # find and delete all .tmp files

find /path -type f -empty                 # find empty files
find /path -type d -empty                 # find empty directories

find /path -maxdepth 1                    # Only search in the specified directory (no recursion)
find /path -mindepth 2                    # Skip the first level and start searching from subdirectories

find /path -inum 123456                   # find files by their inode number

find /path -name "*.sh" -exec echo {} \;  # find .sh files and print their full path
