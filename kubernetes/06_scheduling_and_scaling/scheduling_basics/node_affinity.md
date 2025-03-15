
### **Node Affinity**
Node affinity allows **fine-grained control** over where a Pod should be scheduled based on Node labels.

#### **Example: Required Node Affinity**
```yaml
apiVersion: v1
kind: Pod
metadata:
  name: affinity-pod
spec:
  affinity:
    nodeAffinity:
      requiredDuringSchedulingIgnoredDuringExecution:
        nodeSelectorTerms:
        - matchExpressions:
          - key: disktype
            operator: In
            values:
            - ssd
  containers:
  - name: app-container
    image: nginx
```

---
