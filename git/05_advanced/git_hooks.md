# Git Hooks

Git hooks are scripts that are triggered by specific Git events. These hooks allow you to automate tasks and enforce policies during the Git workflow. They can be used for various tasks like formatting code, sending notifications, checking for proper commit messages, or running tests before commits.

---

## Where to Find Git Hooks
- Git hooks are located in the `.git/hooks` directory of your repository.
- By default, Git provides sample hooks (like `pre-commit.sample`), which are disabled. To enable a hook, remove the `.sample` extension.

---

## Types of Git Hooks

There are two main categories of hooks:

- **Client-side hooks**: Run on operations such as committing and merging. These are run on your local machine.
- **Server-side hooks**: Run on operations like receiving pushed commits. These are configured on the Git server (e.g., in bare repositories).

---

## Common Client-side Hooks

### 1. **pre-commit**
Runs before a commit. It is often used to check the code (e.g., running linters or tests).

#### Example:
```bash
#!/bin/sh
# Example: Prevent committing if any files are staged for deletion
if git diff --cached --name-only --diff-filter=D | grep -q .; then
  echo "Error: you are trying to delete files"
  exit 1
fi
```

---

### 2. **commit-msg**
Checks the commit message before completing the commit.

- **Use Case**: Enforcing commit message formats.

---

### 3. **pre-push**
Runs before `git push`. It’s useful for validating code or running tests before pushing changes to a remote repository.

---

## Using Git Hooks

To activate a hook, create a file in `.git/hooks` with the appropriate hook name (e.g., `pre-commit`, `commit-msg`), and make it executable:

```bash
chmod +x .git/hooks/pre-commit
```

---
