'''
Dependabot (Automated Dependency Updates)

- automatically updates Python dependencies
- prevents security risks from outdated packages
- integrated into GitHub (native support)

1. Dependabot checks requirements.txt, pyproject.toml, or Pipfile.
2. It creates pull requests (PRs) when updates are available.
3. It ensures dependencies stay up-to-date and secure.

.github/dependabot.yml
  version: 2
  updates:
    - package-ecosystem: "pip"
      directory: "/"  # Root directory
      schedule:
        interval: "daily"
'''
