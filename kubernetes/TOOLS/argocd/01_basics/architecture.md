
## Basic ArgoCD Components

### 1. **API Server**
   - Provides a REST and gRPC interface for the CLI, UI, and external integrations.
   - Acts as a gateway for user interactions, authentication, and authorization.
   - Interacts with the Application Controller and Repo Server to fetch application data.

### 2. **Repo Server**
   - Clones Git repositories containing application manifests.
   - Performs Git operations to fetch the latest desired state.
   - Parses and renders configurations from Helm charts, Kustomize, or plain YAML.

### 3. **Application Controller**
   - Continuously monitors the actual state of applications in the Kubernetes cluster.
   - Compares the cluster state with the desired state stored in Git.
   - Triggers reconciliation by applying necessary changes to match the desired state.
   - Manages rollback operations when needed.

ArgoCD provides an automated and scalable way to deploy applications across multiple Kubernetes clusters while maintaining control and observability through GitOps workflows.

---
