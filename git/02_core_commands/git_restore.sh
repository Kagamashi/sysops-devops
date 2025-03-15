
git reset   # Moves the HEAD pointer and optionally discards or keeps changes.
git restore # Discards uncommitted changes

---

# To restore a file to its last committed state:
git restore <file>

# To restore all files:
git restore .

# To revert a file to an earlier commit:
git checkout <commit_hash> -- <file>

---

# revert specific commit
git revert [commit]
# this creates a new commiit that undoes the changes made by [commit] while leaving other commits and history intact

---
