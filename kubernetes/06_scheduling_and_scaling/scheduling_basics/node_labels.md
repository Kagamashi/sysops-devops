
## **Node Labels**
Labels are key-value pairs assigned to Nodes, helping Kubernetes **schedule** Pods onto specific Nodes based on constraints.

#### **Example: Labeling a Node**
```bash
kubectl label nodes node-1 disktype=ssd
```

#### **Using Node Selectors in a Pod**
```yaml
apiVersion: v1
kind: Pod
metadata:
  name: example-pod
spec:
  nodeSelector:
    disktype: ssd
  containers:
  - name: app-container
    image: nginx
```

---
