
## **Horizontal Pod Autoscaling (HPA)**

Automatically scales the number of Pods in a Deployment, ReplicaSet, or StatefulSet based on observed resource usage or custom metrics. HPA ensures that the number of Pods scales horizontally (increases or decreases) according to application load.

### **Key Features**:
- Allows setting **minimum** and **maximum** numbers of Pods.
- Reacts to changes in resource utilization (e.g., CPU, memory) or custom metrics.

### **HPA Metrics**:
1. **Resource Metrics**:
   - CPU
   - Memory

2. **Custom Metrics**:
   - Application-specific metrics, such as HTTP requests per second, queue length, or database queries.
   - Metrics can be collected using Prometheus or custom metric APIs.

### **Use Cases**:
- Applications with fluctuating traffic (e.g., web servers, APIs).
- Batch processing jobs that scale based on workload size.
- Microservices requiring rapid scaling for bursts of traffic.

---
