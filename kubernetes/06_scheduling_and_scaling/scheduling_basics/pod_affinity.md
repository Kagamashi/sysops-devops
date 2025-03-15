

### **Pod Affinity**
Pod affinity **ensures** Pods are scheduled **near** each other (on the same or close Nodes), useful for applications that need low-latency communication.

#### **Example: Pod Affinity**
```yaml
apiVersion: v1
kind: Pod
metadata:
  name: pod-affinity-example
spec:
  affinity:
    podAffinity:
      requiredDuringSchedulingIgnoredDuringExecution:
      - labelSelector:
          matchLabels:
            app: frontend
        topologyKey: "kubernetes.io/hostname"
  containers:
  - name: app-container
    image: nginx
```

---

### **Pod Anti-Affinity**
Pod anti-affinity **ensures Pods do not get scheduled on the same Node**, useful for **high availability** scenarios.

#### **Example: Pod Anti-Affinity**
```yaml
apiVersion: v1
kind: Pod
metadata:
  name: pod-anti-affinity-example
spec:
  affinity:
    podAntiAffinity:
      requiredDuringSchedulingIgnoredDuringExecution:
      - labelSelector:
          matchLabels:
            app: frontend
        topologyKey: "kubernetes.io/hostname"
  containers:
  - name: app-container
    image: nginx
```

---
