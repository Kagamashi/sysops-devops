
## **Metrics Collection in Kubernetes**

### **1. Metrics Server (Kubernetes Resource Metrics)**
- Lightweight component that collects CPU and memory usage for Pods and Nodes.
- Required for **kubectl top** and **Horizontal Pod Autoscaler (HPA)**.

#### **Installing Metrics Server**
```bash
kubectl apply -f https://github.com/kubernetes-sigs/metrics-server/releases/latest/download/components.yaml
```

#### **Viewing Pod & Node Metrics**
```bash
kubectl top pods
kubectl top nodes
```

---
