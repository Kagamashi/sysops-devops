
The **Kubernetes Control Plane** manages the overall cluster state, scheduling, and lifecycle of applications. It consists of several key components:

---

### **API Server (`kube-apiserver`)**
- The **entry point** for all cluster interactions.
- Exposes a RESTful API that other components and users interact with (`kubectl`, clients, controllers).
- Performs **authentication, authorization, and admission control** before modifying cluster state.
- Scales horizontally by deploying multiple instances behind a load balancer.

---
