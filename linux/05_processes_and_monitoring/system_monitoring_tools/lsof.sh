
# lsof displays open files and the processes using them
sudo apt install lsof

lsof                # Show all open files.
lsof -i :80         # List processes using port 80.
lsof +D /var/log/   # Show open files in a directory.
