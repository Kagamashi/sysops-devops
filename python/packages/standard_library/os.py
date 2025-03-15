'''
Operating System Interface

file system operations
environment variables
running shell commands
'''

import os

os.name         # 'posix' for Linux and macOs, 'nt' for Windows 
os.getcwd()     # get current working directory
os.makedirs     # create directory
os.removedirs   # remove directory
os.listdir      # list directory
os.rename       # rename file
os.remove       # remove file
os.path.exists  # check if file exists
os.path.isfile  # check if file is file
os.path.isdir   # check if file is directory
os.path.join    # join path
os.path.split   # split path

# old way
file_path = os.path.join("folder", "file.txt")

# cross-platform environment variables
if os.name == "nt":  # Windows
    os.system("cls")
else:  # macOS/Linux
    os.system("clear")

