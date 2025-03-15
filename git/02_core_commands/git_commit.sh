
# Takes the changes from the staging area and stores them in the repository's history.
# Every commit is associated with a unique ID (SHA-1 hash) and includes a message that describes the changes.

# commit stages changes with message
git commit -m "Your commit message"

# open default text editor for writing a detailed commit message
git commit

# amend last commit (wthout creating a new one)
# if no staged changes exist, this only updates commit message
git commit --amend
