
## **Understanding Kubernetes Scheduler**
The Kubernetes **scheduler** is responsible for placing Pods on Nodes based on resource requirements, constraints, and affinity rules. It evaluates all available Nodes and selects the optimal one for each Pod.

### **High-Level Scheduling Logic:**
1. **Filtering Phase**
   - The scheduler filters out Nodes that **don’t meet** the Pod’s requirements (e.g., insufficient resources, taints, node selectors).
2. **Scoring Phase**
   - The remaining Nodes are ranked based on scoring functions like CPU, memory availability, affinity, and custom scheduling policies.
3. **Binding Phase**
   - The scheduler assigns the Pod to the highest-scored Node and updates the API server.

---
