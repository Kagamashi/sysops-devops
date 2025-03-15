# Pull Request Templates in Azure DevOps

## Creating Templates for Pull Request Descriptions

To create a standardized Pull Request (PR) description template, follow these steps:

1. Add a `.azuredevops` folder in your repository.
2. Inside `.azuredevops`, create a `pull_request_template.md` file.

### Example: Default Pull Request Template
```markdown
# Pull Request

## Description

**PBI Links:**  
[Links to associated PBIs - by default all PBIs in the Releasing section of the ADO Board.]

**To-do after merge:**  
[List of things that need to be manually updated after the PR is completed.]
- [ ] **Create Git tag in format `current_date.version` (e.g., `2024-01-01.1`)**
- [ ] **Update Git tag in `dcp_state`**
- [ ] **References in pipelines for NonProd and Prod**
- [ ] **TfVersion in `subscription_config` for NonProd and Prod**

## Definition of Done
- [ ] Code is reviewed and approved.
- [ ] Documentation is updated.
- [ ] Tests pass successfully.
```

## Creating Different Templates for Different Branches
You can define separate templates for specific branches. For example, if you want a different PR template when pushing to the `develop` branch:

1. Create a `.azuredevops/pull_request_template/branches/` directory.
2. Inside this directory, add `develop.md`.

### Example: Develop Branch Pull Request Template
```markdown
# Pull Request

## Description

**PBI Link:**  
[Link to associated PBIs - by default all PBIs in the Releasing section of the ADO Board.]

## Definition of Done
- [ ] Code is reviewed and approved.
- [ ] Tests pass successfully.
```

## Summary
- Organizing PR templates enhances workflow consistency.
- Store general templates in `.azuredevops/pull_request_template.md`.
- Customize templates per branch in `.azuredevops/pull_request_template/branches/`.
