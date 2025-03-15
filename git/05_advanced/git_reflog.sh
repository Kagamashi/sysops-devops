
# reflog is a mechanism that records updates to branch tips and HEAD
# it allows recovery of lost commits, reverting to previous states and tracking branch movemenets

# history of HEAD changes
git reflog

# recovering a reset commit
git reset --hard HEAD@{n}   # n is the index of the desired commit from git reflog

# restoring a deleted branch
git checkout -b [branch_name] [commit_hash] # find last known commit from git reflog

# undoing the last commit
git reset --hard HEAD@{1}

# undoing a merge
git reset --hard ORIG_HEAD

# remove old reflog entries
git reflog expire --expire=90.days.ago --all

# delete entire reflog
git reflog delete --all
