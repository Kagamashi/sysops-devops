
## Merge Conflicts and Resolution

### Typical Conflict Markers

When a merge conflict occurs, Git marks the conflicting areas in the file:

```sh
<<<<<<< HEAD
Your changes
=======
Incoming changes
>>>>>>> branch-name
```

### Conflict Resolution Workflow

1. Identify conflicting files:
   ```sh
   git status
   ```
2. Open and manually edit the conflicting files to keep the correct changes.
3. Mark conflicts as resolved:
   ```sh
   git add <resolved_file>
   ```
4. Complete the merge:
   ```sh
   git commit
   ```

### Interactive Conflict Resolution Tools

- **VS Code**: Opens the conflict resolution UI automatically.
- **Sourcetree**: Provides a graphical way to resolve conflicts.
- **KDiff3/Meld**: Third-party tools to assist with conflict resolution.
- **Git's built-in mergetool**:
  ```sh
  git mergetool
  ```

---
