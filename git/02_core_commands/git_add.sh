
# Working Directory - Where files are modified.
# Staging Area (Index) - Where changes are prepared for commit.
#   staging area allows to selectively choose which changes will be a part of commit
# Repository - Where committed changes are stored.

# move files from the working directory to the staging area:
git add <file>  # stage a specific file
git add .       # stage all changes
git add -u      # add all changes to tracked files only (no new files)

# unstage changes
git restore --staged <file>  # Unstage a specific file

# discard changes
git restore <file>  # Restore a specific file to its last committed state
