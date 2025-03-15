
Use rebase when you want a linear, cleaner commit history.

To reapply commits from one branch onto another:
# git rebase <branch_name>

If conflicts occur, resolve them and continue:
# git rebase --continue

To abort a rebase:
# git rebase --abort
