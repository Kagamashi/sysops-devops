
## Core Concepts and Terminology

### **Application**
   - A core ArgoCD object representing a deployed workload in Kubernetes.
   - Contains metadata defining the desired state, such as source repository, target cluster, and sync policies.
   
### **Project**
   - A logical grouping of applications that share policies, permissions, and access controls.
   - Helps enforce security and governance by limiting which repositories, clusters, and namespaces applications can interact with.

### **Sync vs. Health States**
   - **Sync State:** Reflects whether the application’s live state matches the desired state in Git.
     - *Synced:* The cluster matches the declared state.
     - *OutOfSync:* The cluster deviates from the declared state.
   - **Health State:** Indicates the current operational status of an application.
     - *Healthy:* The application is running as expected.
     - *Progressing:* A change is in progress.
     - *Degraded:* The application is failing or encountering errors.
     - *Unknown:* ArgoCD cannot determine the application’s status.

---
