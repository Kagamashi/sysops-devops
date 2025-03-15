
A **Kubernetes Node** is a worker machine that runs containerized workloads. Each node contains the following key components:

---

### **Kubelet**
- The **primary agent** that runs on every node.
- Communicates with the **API server** to receive scheduling instructions.
- Manages **Pod lifecycle**: downloads container images, starts/stops containers.
- Monitors container health using **Liveness and Readiness Probes**.

---
