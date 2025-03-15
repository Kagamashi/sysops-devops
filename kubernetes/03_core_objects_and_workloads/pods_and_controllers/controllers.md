
## Controllers:

Controllers ensure that the desired state of applications is maintained automatically. 

Different controllers manage Pods in different ways:
- **Replicaset**: ensures a fixed number of Pod replicas
- **Deployment** (uses ReplicaSet internally): manages rolling updates and rollbacks
- **DaemonSet**: runs one pod per node
- **StatefulSet:** managed stateful applications, used for databases, message queues..
 
---

## Comparison:

| Controller   | Purpose | Scaling | Use Case |
|-------------|---------|---------|----------|
| **ReplicaSet** | Ensures a fixed number of Pods | Manual | Simple workload management |
| **Deployment** | Adds rolling updates & rollbacks | Automated | Stateless apps, web services |
| **DaemonSet** | Runs exactly one Pod per node | Not scalable | Logging, monitoring, security agents |
| **StatefulSet** | Maintains persistent identity & storage | Ordered scaling | Databases, message queues |

---

