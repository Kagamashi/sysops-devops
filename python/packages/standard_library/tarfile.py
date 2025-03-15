'''
Working with .tar Archives

compressing and extracting .tar files
'''

from tarfile import TarFile

with TarFile.open("archive.tar", "w") as tar: # open a .tar file
    tar.add("example.txt") # add file to .tar archive

with TarFile.open("archive.tar", "r") as tar:
    tar.extractall("output_folder") # extract all files to path
