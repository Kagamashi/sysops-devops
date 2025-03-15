## Kubernetes

**Kubernetes** is an open-source container orchestration platform for automating application deployment, scaling, and management. It groups containers into **logical units** for easy management and discovery.

- **Official Docs**: [https://kubernetes.io/docs/](https://kubernetes.io/docs/)
- **GitHub Repository**: [https://github.com/kubernetes/kubernetes](https://github.com/kubernetes/kubernetes)
- **Install Tools**:  
  - **Minikube** (local cluster): [https://minikube.sigs.k8s.io/docs/](https://minikube.sigs.k8s.io/docs/)  
  - **Kind** (Kubernetes IN Docker): [https://kind.sigs.k8s.io/](https://kind.sigs.k8s.io/)
- **Reference**: [Kubernetes API Reference](https://kubernetes.io/docs/reference/kubernetes-api/)

---

### Dictionary

- **Cluster**: A set of machines (nodes) running Kubernetes, hosting containerized workloads.
- **Node**: A worker machine in Kubernetes (VM or physical server) that runs containerized apps.
- **Pod**: The smallest deployable unit in Kubernetes, wrapping one or more containers that share storage/network.
- **Service**: An abstraction that provides a stable endpoint (DNS/IP) to access a set of pods.
- **Deployment**: A higher-level controller for managing stateless apps, handling rolling updates and rollbacks.
- **StatefulSet**: Manages **stateful** apps with stable network IDs, persistent storage, and ordered deployment/scaling.
- **DaemonSet**: Ensures a **copy of a pod** runs on all (or some) nodes in the cluster.
- **Ingress**: An API object that manages external HTTP/HTTPS access to services in a cluster.
- **CRD (Custom Resource Definition)**: Extends Kubernetes API to create custom resources managed by Operators or controllers.

---

### CRDs (Custom Resource Definitions)

Kubernetes **natively** supports many built-in resources (Deployments, Services, etc.). **CRDs** allow you to define new resource types:

1. **Custom Resource Definition**  
   YAML definitions that specify a new resource type’s schema and behavior.
2. **Operators** (built on CRDs)  
   Automated application management logic (e.g., handling DB upgrades, backups).
