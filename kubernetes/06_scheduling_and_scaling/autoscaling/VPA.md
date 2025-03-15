

## **Vertical Pod Autoscaling (VPA)**

Adjusts resource requests and limits (CPU and memory) of individual Pods based on their usage patterns. VPA optimizes resource allocation for each Pod, ensuring it has the correct resources for its workload.

### **Key Features**:
- Operates in **recommendation mode**, where it suggests resource limits without applying them automatically.
- In **full auto mode**, VPA may evict Pods that need resource adjustments, potentially causing service disruptions.

### **Use Cases**:
- Applications with dynamic resource needs, such as databases or AI/ML workloads.
- Long-running processes where resource consumption changes over time.
- Applications where resource requests are difficult to predict at deployment time.

---
