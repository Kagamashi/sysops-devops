## **How Everything Fits Together**

1. A user or controller submits a **Pod definition** to the API Server.
2. The **Scheduler** selects the best node for the Pod.
3. The **Kubelet** on the selected node pulls the container images and starts the Pod.
4. The **Kube Proxy** sets up networking rules to allow inter-Pod communication.
5. Controllers monitor and reconcile the cluster state to match the desired configuration.
6. The **etcd database** ensures all cluster state is persisted and distributed across control plane nodes.

By understanding how control plane and node components interact, Kubernetes engineers can troubleshoot complex cluster issues, optimize performance, and design robust architectures.

---
