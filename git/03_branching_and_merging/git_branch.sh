
# Branches allows to work on different features, fixes, or experiments in isolation from the main codebase.

# create new branch
git branch [branch_name]

# list all branches 
git branch # currently active branch will be marked with asterisk (*)

# delete a branch
git branch -d [branch_name]

# force delete (if branch is not fully merged)
git branch -D [branch_name]

# rename current branch
git branch -m [new_branch_name]


# TRACKING
# tracking branch is linked to a remote branch
git branch --track [branch_name] origin/[branch_name]

# see tracking information
git branch -vv

# push new local branch and set it to track a remote branch
git push -u origin [branch_name]
