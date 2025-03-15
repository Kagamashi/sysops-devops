## Argo CD

**Argo CD** is a **declarative GitOps** continuous delivery tool for Kubernetes. It continuously monitors your running applications and compares their live state against the desired state defined in Git repositories.

- **Official Docs**: [https://argo-cd.readthedocs.io/](https://argo-cd.readthedocs.io/)
- **GitHub Repository**: [https://github.com/argoproj/argo-cd](https://github.com/argoproj/argo-cd)
- **Getting Started**: [https://argo-cd.readthedocs.io/en/stable/getting_started/](https://argo-cd.readthedocs.io/en/stable/getting_started/)
- **CLI Reference**: [https://argo-cd.readthedocs.io/en/stable/user-guide/argo-cd-cli/](https://argo-cd.readthedocs.io/en/stable/user-guide/argo-cd-cli/)

---

### Dictionary

- **GitOps**: A development workflow where the desired state of your environment is stored in Git, and Argo CD automatically deploys those changes.
- **Application**: A CRD that represents a deployed service or set of resources in a Kubernetes cluster.
- **AppProject**: Defines a logical grouping of applications, controlling access permissions and resource usage.
- **Sync**: The process of bringing the live state of the cluster into alignment with the desired state in Git.
- **Hook**: Custom resource hooks triggered at specific lifecycle events (e.g., pre-sync, post-sync).
- **Self-Healing**: Argo CD detects drift and can optionally re-sync to restore desired state.

---

### CRDs (Custom Resource Definitions)

Argo CD introduces several CRDs in a Kubernetes cluster:

1. **Application**  
   Represents the desired state of a collection of resources in Git and their deployment targets.

2. **AppProject**  
   Defines project-wide settings, such as allowed source repos, destinations, and cluster resource white/blacklists.

(For multi-cluster or advanced setups, **ApplicationSet** may be installed from the [Argo Project's ApplicationSet controller](https://github.com/argoproj-labs/applicationset).)

---
