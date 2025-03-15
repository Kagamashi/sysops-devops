
# Used to fetch changes from a remote repository and automatically merge them into your current branch.
# It combines git fetch (downloads changes) and git merge (applies changes) in one command.

# pull changes from default remote (origin) and current branch
git pull

# pull changes from specific branch
git pull origin [branch_name]

# default git pull peforms a merge, to always pull with rebase
git pull --rebase
git config --global pull.rebase true

---

# git fetch 
# Downloads changes (commits, branches, tags) from a remote repository but does not automatically merge them into your working directory.
# This is useful for reviewing changes before merging.

# fetch updates from default remote or specific branch
git fetch origin
git fetch origin [branch_name]

# inspect fetched changes
git log origin/[branch_name]

# apply changes
git merge origin/[branch_name]

---

# git merge
# Used to combine the changes from one branch into another. Typically, you merge a feature branch into the main branch after completing your work.
#   - Fast-forward merge: If there are no new commits in the target branch, Git will move the pointer forward (no extra commit is needed).
#   - Three-way merge: If both branches have commits, Git will create a new merge commit combining both histories.

# merge branch into current branch
# this command will integrate changes from branch_name into branch we are currently on
git merge [branch_name]
