# Git Branching Strategies

## 1. **Feature Branching**
Each new feature or bug fix is developed in a separate branch.

**Workflow:**
1. Create a new branch for the feature:
   ```sh
   git checkout -b feature/<feature-name>
   ```
2. Work on the feature and commit changes.
3. Push the branch to the remote repository:
   ```sh
   git push origin feature/<feature-name>
   ```
4. Open a pull request (PR) for review and merge.

**Pros:**
- Isolates changes for better testing and review.
- Enables multiple developers to work in parallel.

**Cons:**
- Requires active branch management.

---

## 2. **Git Flow**
A structured workflow that includes feature, release, and hotfix branches.

**Branches:**
- `main` – Stable, production-ready code.
- `develop` – Integration branch for development.
- `feature/*` – Branches for new features.
- `release/*` – Branches for preparing releases.
- `hotfix/*` – Branches for urgent fixes on production.

**Workflow:**
1. Start a feature:
   ```sh
   git checkout -b feature/<feature-name> develop
   ```
2. Merge into `develop` when complete.
3. When ready for release:
   ```sh
   git checkout -b release/<version> develop
   ```
4. Merge `release/<version>` into `main` and tag it.
5. If necessary, create hotfix branches from `main`.

**Pros:**
- Structured approach, great for large teams.
- Clear separation between different stages.

**Cons:**
- Can be complex for small projects.
- Requires more branch management.

---

## 3. **GitHub Flow**
A simplified workflow that uses short-lived feature branches.

**Workflow:**
1. Create a new branch off `main`:
   ```sh
   git checkout -b feature/<feature-name>
   ```
2. Work on the feature, commit, and push changes.
3. Open a pull request.
4. Merge into `main` after approval.
5. Deploy immediately.

**Pros:**
- Simple and fast-moving.
- Great for continuous deployment.

**Cons:**
- Lacks structured release management.
- May not be ideal for complex projects.

---

## 4. **Trunk-Based Development**
Developers work directly on `main` or short-lived branches.

**Workflow:**
1. Work on small changes directly on `main`.
2. Use feature flags for incomplete features.
3. Merge frequently to avoid long-lived branches.

**Pros:**
- Encourages continuous integration.
- Reduces merge conflicts.

**Cons:**
- Requires strong testing and feature flagging.
- Less isolation for incomplete features.

---

## 5. **Release Branching**
Maintains multiple branches for different software versions.

**Workflow:**
1. Create a release branch:
   ```sh
   git checkout -b release/<version>
   ```
2. Merge bug fixes into both `main` and release branches as needed.
3. Tag releases:
   ```sh
   git tag v<version>
   ```

**Pros:**
- Supports multiple versions in production.
- Good for long-term maintenance.

**Cons:**
- Increased branch maintenance effort.

---

## Choosing the Right Strategy
| Strategy                  | Best For                          |
|---------------------------|----------------------------------|
| Feature Branching        | Teams working on independent features |
| Git Flow                 | Large projects with structured releases |
| GitHub Flow              | Fast-moving projects and CI/CD |
| Trunk-Based Development  | Continuous deployment environments |
| Release Branching        | Projects requiring long-term maintenance |
