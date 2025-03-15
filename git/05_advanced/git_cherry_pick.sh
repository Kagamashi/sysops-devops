
# Git Cherry-Pick allows applying specific commits from one branch into another without merging the entire branch.

# 1. Cherry-picking a single commit:
# This command applies the changes from the specific commit to your current branch.
git cherry-pick [commit_hash]
git cherry-pick a1b2c3d

# 2. Cherry-picking multiple commits:
# You can cherry-pick multiple commits by providing a range of commits using two commit hashes.
git cherry-pick [commit_hash_1] [commit_hash_2]
git cherry-pick a1b2c3d e4f5g6h

# 3. Cherry-pick a range of commits (inclusive):
# You can specify a range of commits by using the commit hashes with two dots.
git cherry-pick [start_commit]..[end_commit]
git cherry-pick a1b2c3d..e4f5g6h

# 4. Handling cherry-pick conflicts:
# If a conflict occurs during cherry-picking, Git will stop and allow you to resolve it.
# After resolving the conflict, add the resolved files and continue with the cherry-pick:
git add [resolved_file]
git cherry-pick --continue

# If you want to abort the cherry-pick process due to unresolved conflicts:
git cherry-pick --abort

# 5. Cherry-picking without committing:
# Use the --no-commit option to apply the changes without making a commit.
git cherry-pick --no-commit [commit_hash]

# 6. Skip a problematic commit:
# If you encounter an issue with a commit during cherry-picking, you can skip it:
git cherry-pick --skip
