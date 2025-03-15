
Use merge when you want to preserve the branch history.

# A fast-forward merge occurs when the branch being merged has no diverging changes:
git merge <branch_name>

# If the branches have diverged, Git creates a merge commit:
git merge --no-ff <branch_name>
