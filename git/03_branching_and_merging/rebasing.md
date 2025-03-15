# Rebasing Branches and Interactive Rebasing

## Rebasing Branches (`git rebase`)

**Rebasing** is a Git operation that moves or "replays" commits from one branch onto another. It allows you to integrate changes from one branch into another by applying your changes on top of the existing history, rather than merging them. Rebasing results in a linear commit history, which can be cleaner and easier to understand.

### Common Usage:
- **Rebase your branch onto another branch**:
  ```bash
  git checkout <feature-branch>
  git rebase <base-branch>
  ```
  Example:
  ```bash
  git checkout feature
  git rebase main
  ```

This command will take the commits from the `feature` branch and "replay" them on top of the latest commits in the `main` branch. After rebasing, your `feature` branch will have a linear history as if it was developed from the latest `main` branch.

### Benefits of Rebasing:
- **Linear History**: Keeps your project’s commit history clean by avoiding merge commits.
- **Cleaner Collaboration**: You can rebase your feature branch before merging it into the main branch to avoid unnecessary merge commits, making the history easier to follow.

### Considerations:
- **Don’t rebase shared branches**: Rebasing rewrites commit history, which can confuse other collaborators who are working on the same branch. It is best used for local changes or branches that haven't been shared yet.

---

## Interactive Rebasing (`git rebase -i`)

**Interactive rebasing** (`git rebase -i`) is an advanced form of rebasing that gives you control over each commit during the rebase process. It allows you to modify, reorder, combine, or even delete commits.

### Common Usage:
- **Interactive rebase for a specified number of previous commits**:
  ```bash
  git rebase -i HEAD~<number_of_commits>
  ```
  Example:
  ```bash
  git rebase -i HEAD~3
  ```
  This command opens an interactive editor where you can choose how to handle each of the last 3 commits.

### Actions During Interactive Rebase:
- **pick**: Keep the commit as is.
- **reword**: Keep the commit but change its commit message.
- **edit**: Pause the rebase to modify the commit (e.g., to change or add files).
- **squash**: Combine the commit with the previous commit.
- **fixup**: Like squash, but discards the commit message.
- **drop**: Remove the commit entirely from the history.

### Example of an Interactive Rebase:
When you run `git rebase -i`, you’ll see a list of commits in your text editor:
```plaintext
pick a1b2c3 Commit message 1
pick d4e5f6 Commit message 2
pick g7h8i9 Commit message 3
```

You can change the action for each commit. For example:
```plaintext
pick a1b2c3 Commit message 1
reword d4e5f6 Commit message 2
squash g7h8i9 Commit message 3
```

In this example:
- The second commit will be kept but with an edited message.
- The third commit will be squashed (combined) with the second commit.

### Completing the Rebase:
After you make the changes in the interactive editor, Git will replay the commits as specified. You may need to resolve conflicts if they arise during the process.

---
