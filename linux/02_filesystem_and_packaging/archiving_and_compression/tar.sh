# archive multiple files into a single file, but it does not compress by default

#   - packs files and directories into a single .tar file (also called tarball)
#   - tar Archive also stores permission and ownership informations about files and directories

c → Create an archive
x → Extract files
v → Verbose output
f → Use archive file
z → Use gzip compression
j → Use bzip2 compression
J → Use xz compression

tar -cvf archive.tar file1 file2    # Create a tar archive (no compression).
tar -xvf archive.tar                # Extract a tar archive.
tar -tvf archive.tar                # List contents of a tar archive.
tar -cvzf archive.tar.gz folder/    # Create a compressed tarball using gzip.
tar -xvzf archive.tar.gz            # Extract a gzip-compressed tarball.
tar -cvjf archive.tar.bz2 folder/   # Create a compressed tarball using bzip2.
tar -xvjf archive.tar.bz2           # Extract a bzip2 compressed tarball.
tar -cvJf archive.tar.xz folder/    # Create a compressed tarball using xz.
tar -xvJf archive.tar.xz            # Extract an xz compressed tarball.

tar X<(ls | file -f - | grep -i MPEG | cut -d: -f 1) -c -f file.tar * # exclude MPEG file from content of file.tar
sudo tar --extract --file archive.tar --directory /tmp/               # to ensure all permission/ownership informations get restored
