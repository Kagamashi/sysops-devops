
# Used to temporarily save changes that we are not ready to commit.
# It allows to switch branches or work on something else without losing our current work.

# stash current changes
git stash 
# this will save our modifications and revert working directory to the last commited state

# view list of stashes
git stash list

# apply most recent stash (without removing it from the stash list)
git stash apply

# apply and remove the most recent stash (pop it off the stash list)
git stash pop

# clear all stashes
git stash clear
