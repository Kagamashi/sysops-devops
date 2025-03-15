## Key Concepts

### Agent
- Installable software that runs build or deployment jobs.
- Types:
  - **Hosted Agents**: Pre-configured VMs maintained by Microsoft.
  - **Self-Hosted Agents**: Configured and maintained by users.

### Agent Pool
- Collection of agents used to execute pipeline jobs.
- Supports **parallelism**, enabling multiple jobs to run concurrently.

### Artifact
- Collection of files or packages created by a build pipeline.
- Stored for use in later deployment stages.

### Build
- A single execution of a pipeline, collecting logs and test results.
- Produces artifacts that can be deployed.

### Pipeline
- Defines the process for continuous integration and deployment.
- Comprised of **stages, jobs, and tasks**.
- YAML-based pipelines enable version-controlled configurations.

### Release
- Execution of a release pipeline, deploying artifacts to multiple stages.

### Stage
- Logical division of a pipeline (e.g., build, test, deploy).
- Supports approval gates and validation checks.

### Task
- Individual operations in a pipeline (e.g., compiling code, running tests, deploying).

### Trigger
- Determines when a pipeline runs.
- Types:
  - **Code push**: Triggered on commits to a repository.
  - **Scheduled**: Runs at predefined times.
  - **Pipeline completion**: Runs after another pipeline finishes.

---

## CI/CD in Azure Pipelines

### **Continuous Integration (CI)**
- Automatically integrates code changes into a shared repository.
- Runs builds and tests on every commit.

### **Continuous Deployment (CD)**
- Automates application deployment to multiple environments (dev, staging, production).
- Supports **multi-stage pipelines**.

### **Build Pipeline**
- Automates compilation, testing, and artifact creation.
- Stores build outputs for deployment.

### **Release Pipeline**
- Manages application deployment to different environments.
- Supports approval workflows and rollback mechanisms.

## Deployment Strategies
- **Rolling Deployments**: Incremental update of instances.
- **Blue-Green Deployments**: Deploys to a new environment before switching traffic.
- **Canary Releases**: Gradual rollout to a subset of users.

## Optimizing Performance
- **Parallel Jobs**: Speed up builds by running multiple jobs concurrently.
- **Agent Pools**: Distribute workloads across multiple agents.
- **Artifact Storage Optimization**: Clean up unused artifacts to reduce storage costs.
