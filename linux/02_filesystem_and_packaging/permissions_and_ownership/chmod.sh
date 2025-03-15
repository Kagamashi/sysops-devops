# change file access permissions

# [rwx][rwx][rwx]
# owner group others
# permissions are evaluated in linear fashion from left to right: OWNER -> GROUP -> OTHER

r read    4
w write   2
x execute 1
s suid    4000
s sguid   2000
t sticky  1000

chmod 755 file.txt                      # set permissions to rwxr-xr-x for file.txt
chmod +x script.sh                      # add execute permission to script.sh
chmod -R 644 /path/to/directory         # set permissions recursively to rw-r--r-- for all files in a directory
chmod u+rwx script.sh                   # add permissions to users on script.sh file
chmod g-rw script.sh                    # remove read and write permissions from group
chmod o=w scripth,sh

# SUID : runs file with the file owner’s permissions.
chmod u+s file.txt                       # -rwsr-xr-x
chmod 4755 file.txt

# SGID : files inherit the group of the directory.
chmod g+s /files                         # drwxr-sr-x
chmod 2755 /directory                    # files created inside inherit its group

# Sticky Bit : only the owner can delete their files in the directory.
chmod +t files/                          # drwxrwxrwt
