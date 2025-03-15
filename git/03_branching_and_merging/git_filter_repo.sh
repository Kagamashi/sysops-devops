
# To remove a file from the entire Git history:
git filter-repo --path <file> --invert-paths

# To remove a string (e.g., a password) from all commits:
git filter-repo --replace-text <(echo "old-secret==>new-placeholder")

# After modifying history, you must force push changes:
git push --force

# ⚠️ Caution: Force pushing rewrites history and can cause issues for others working on the same branch. Ensure all collaborators are aware before doing so.
