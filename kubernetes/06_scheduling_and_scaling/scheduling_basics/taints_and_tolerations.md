
## **Taints and Tolerations**
- **Taints** are applied to nodes and prevent Pods from being scheduled on the node unless the Pod has a matching toleration.
- **Tolerations** are applied to Pods and allow them to be scheduled on nodes with matching taints.

#### **Tainting a Node**:
```bash
kubectl taint nodes node1 key=value:NoSchedule
```
This taints the node `node1` with `key=value:NoSchedule`.

#### **Pod with a Matching Toleration**:
```yaml
apiVersion: v1
kind: Pod
metadata:
  name: my-app
spec:
  tolerations:
  - key: "key"
    operator: "Equal"
    value: "value"
    effect: "NoSchedule"
  containers:
  - name: my-container
    image: nginx
```

---
