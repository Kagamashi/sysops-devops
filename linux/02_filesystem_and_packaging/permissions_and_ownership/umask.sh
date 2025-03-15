# umask (user file-creation mode mask) command determines default permissions for new files and directories

umask           # shows current umask value
umask [value]   # sets new umask value

## default permissions:
#   files: 666       (rw-rw-rw-) read, write write for all
#   directories: 777 (rwxrwxrwx) read, write, execute for all

# umask removes permissions based on its value

# example:
umask 022
#   files: 666 - 022 = 644    (rw-r--r--)
#   directories: 777 - 022 = 755 (rwxr-xr-x)


## persistent umask settings:
#   ~/.bashrc or ~/.profile
echo "umask 027" >> ~/.bashrc
source ~/.bashrc

#   /etc/profile or /etc/bash.bashrc
echo "umask 022" >> /etc/profile


## common umask values:
0000    # no restrictions
0022    # default for most systems (readable by all)
0077    # private files and directories
0027    # restricts access to the owner and group