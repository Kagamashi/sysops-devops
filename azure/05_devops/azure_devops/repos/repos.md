### Working with Large Repositories
- Use **shallow clones** to save space and sync time:
  ```sh
  git clone --depth [depth] [clone-url]
  ```
- Clone only a single branch:
  ```sh
  git clone --single-branch --branch [branch-name] [clone-url]
  ```
- **Scalar** for large repositories:
  - Implements partial clone for faster access.
  - Uses background prefetch to fetch objects efficiently.
  - Supports sparse-checkout to limit the working directory size.
  - Uses commit-graph for faster history lookup:
    ```sh
    git commit-graph write --reachable
    ```

### Repository Management in ADO
- Use **Monorepo** for large projects to consolidate teams but be mindful of complexity.
- **Multi-repo strategy** enables modularization and isolated version control.

### Changelog Management
- Auto-generate changelogs using Git commands:
  ```sh
  git log [options] vX.X.X..vX.X.Y | helper-script > projectchangelogs/X.X.Y
  ```
- Use tools like **GitChangelog** or **github-changelog-generator**.

### Data Recovery in ADO
- **Recovering commits:**
  ```sh
  git log
  git checkout <commit>
  ```
- **Restoring deleted files:**
  ```sh
  git checkout <commit_SHA>^ -- example.txt
  ```
- **Recovering lost commits:**
  ```sh
  git reflog
  git fsck --lost-found
  ```

### Git Repository Cleanup in ADO
- **Remove large or sensitive files:**
  ```sh
  bfg --delete-files file_I_should_not_have_committed
  ```
- **Rewrite history using filter-repo:**
  ```sh
  git filter-repo --path file_to_remove --invert-paths
  ```
