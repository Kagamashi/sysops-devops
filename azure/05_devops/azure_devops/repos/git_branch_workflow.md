## Common Git Branch Workflows
Most workflows use a centralized repository where developers push and pull changes. Common workflows include:

### 1. Trunk-Based Development
- Developers commit directly to the main branch ("trunk" or "master").
- Emphasizes continuous integration (CI) with frequent, small commits.
- Automated testing ensures stability.

### 2. Feature Branch Workflow
- Each new feature is developed in an isolated branch.
- Developers merge tested and reviewed feature branches into the main branch.
- Supports parallel development, code reviews, and CI stability.

### 3. Release Branch Workflow
- A release branch is created from the main branch for final testing and stabilization.
- Bug fixes and last-minute improvements are applied before merging into the main branch.
- Ensures the main branch remains development-ready.

### 4. Forking Workflow
- Each developer has a personal repository.
- Contributions are made via pull requests.
- Common in open-source projects to maintain controlled access.

## Branch Protection and Merge Restrictions
### Azure DevOps
- Branch protection policies ensure quality and security.
- Require PR reviews, linked work items, and resolved comments before merging.
- Merge types: basic, squash, rebase, or merge commit.
- Additional constraints: build validation, status checks, and automatic reviewers.

### GitHub
- Branch protection rules enforce review and testing policies.
- PRs required before merging.
- Status checks, signed commits, and conversation resolution can be enforced.
- Branch locking prevents unintended modifications.