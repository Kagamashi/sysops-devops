# Better compression that GZIP
bzip2 file                              # Compress file -> file.bz2
bzip2 -k file                          # Compress while keeping the original file
bunzip2 file.bz2                        # Decompress a bzip2 compressed file


# Create ZIP archives
zip archive.zip file1 file2            # Create a ZIP archive with multiple files
zip -r archive.zip folder/             # Compress a directory recursively
unzip archive.zip                      # Extract a ZIP archive
unzip -l archive.zip                   # List contents of a ZIP file


# high compression ratio
xz file                                 # Compress file -> file.xz
xz -k file                             # Compress while keeping the original file
unxz file.xz                            # Decompress an xz compressed file


# GNU Zip - single file compression
gzip file                               # Compress file -> file.gz
gzip -k file                           # Compress while keeping the original file
gunzip file.gz                          # Decompress a gzip compressed file
