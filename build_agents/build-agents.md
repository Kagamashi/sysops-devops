
Build agent is a worker machine that executes build and deployment tasks in CI/CD pipeline.

It can run on a physical machine, VM, container or in cloud service.

Built agents are responsible for:
- compiling source code
- running automated tests
- packaging artifacts
- deploying applications
- executing other automation tasks like security scans, static analysis, database migrations


1. build agent registers with CI/CD server
2. job assignment
when dev pushes code, triggers a pipeline, or scheudles a job the CI/CD system assigns tasks to an available build agent
3. Execution of Build Tasks

The agent clones the repository and executes build steps as per the pipeline definition.
It runs build scripts, compiles the code, executes tests, and generates reports.
4. Artifact Storage and Deployment

After completing the build process, the agent can push the build artifacts to an artifact repository (e.g., Azure Artifacts, JFrog Artifactory, Nexus).
If deployment is part of the pipeline, the agent deploys the application to the target environment (e.g., Kubernetes, VMs, App Services).
5. Clean-up and Shutdown

Some agents clean up workspace files to ensure a fresh start for the next job.
Agents running in auto-scaling environments (e.g., cloud containers) might terminate themselves after job completion.


Types of Build Agents
Self-hosted agents (Managed by users):

You deploy them on your own infrastructure.
Ideal for custom environments, on-prem setups, or private networking.
Examples: A dedicated VM running an Azure DevOps agent, a self-hosted GitHub Actions runner.
Cloud-hosted agents (Managed by CI/CD provider):

Provided by services like Azure DevOps, GitHub Actions, and GitLab.
Good for auto-scaling and maintenance-free operation.
Examples: GitHub-hosted runners, Azure DevOps Microsoft-hosted agents.
Container-based agents:

Run inside a container to provide a clean and reproducible environment.
Example: Using a Docker-based agent in Jenkins.
