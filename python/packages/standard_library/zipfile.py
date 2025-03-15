'''
Working with .zip Archives

compressing and extracting .zip files
'''

from zipfile import ZipFile

# Creating a zip file
with ZipFile("archive.zip", "w") as zipf: # open zip archive
    zipf.write("example.txt")   # add file to zip archive 

# Extracting a zip file
with ZipFile("archive.zip", "r") as zipf:
    zipf.extractall("output_folder") # extract all files to path
