
# df shows disk space usage for mounted filesystems.

df -h     # Display disk usage in human-readable format.
df -i     # Show inode usage on each filesystem.
df /home  # Show disk usage for /home.


# du estimates space usage per directory.

du -sh /var/log/    # Show total size of /var/log/.
du -ah /home/user   # Show detailed file and directory sizes.
du -csh *           # Summarize total disk usage of current directory.
