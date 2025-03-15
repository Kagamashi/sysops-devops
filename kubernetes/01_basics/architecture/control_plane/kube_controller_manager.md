
### **Controller Manager (`kube-controller-manager`)**
- Runs all built-in Kubernetes controllers responsible for maintaining desired cluster state.
- Types of controllers:
  - **Node Controller**: Detects and responds to node failures.
  - **Deployment Controller**: Ensures the correct number of replicas for Deployments.
  - **Service Account Controller**: Manages default accounts and API tokens.
  - **Persistent Volume Controller**: Handles dynamic storage provisioning.
- Continuously **watches for changes** and applies corrective actions.

---
