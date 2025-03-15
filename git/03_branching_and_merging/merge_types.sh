# REGULAR MERGE
# merge one branch into another, preserving all original commits and adding "merge commit" that ties the histories together
git checkout main
git pull
git merge develop # merge source branch into main
# if main and develop have diverged, a merge commit is created
# if main and develop have not diverged, a fast-forward merge is performed
git merge --no-ff develop # to force merge commit and avoid fast-forward merge
# resolve any merge conflicts
git add [fixed-file]
git commit
git push


# FAST FORWARD MERGE
# happens when main has no new commits compared to develop
# Git can just 'move' main pointer forward to develop's latest commit without creating merge commit
git checkout main
git pull 
git merge develop # fast-forward merge
git push


# SQUASH MERGE
# condenses all commits from develop into single new commit on main
# often useful to clean up a series of small 'fix' or 'debug' commits into one commit with cohesive message
git checkout main
git pull
git merge --squash develop
# it applies all changes from develop into working dir but does not create a merge commit
git commit -m "Merge branch 'develop' into main"
git push


# re