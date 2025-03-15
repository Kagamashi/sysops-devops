
## Common Scaling Patterns

### **1. Event-Driven Batch Processing**
- Use **ScaledJob** for scaling workloads that process events from a queue.
- Example: A **log processing pipeline** that runs batch jobs only when new logs arrive.

### **2. Queue-Based Microservices**
- Use **ScaledObject** to auto-scale services that consume messages from a queue.
- Example: A **payment processing service** that scales based on the number of unprocessed transactions.

### **3. Serverless Event Consumers**
- Use **ScaledObject** to scale down services to zero when there are no events.
- Example: A **webhook listener** that processes GitHub events dynamically.

---
