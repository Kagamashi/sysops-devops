# Kubernetes Logs and Metrics

## **Collecting and Viewing Logs**
Kubernetes provides multiple ways to collect and inspect logs from Pods, containers, and system components.

### **1. Viewing Logs with kubectl**
#### **Basic Pod Logs**
```bash
kubectl logs <pod-name>
```

#### **Logs from a Specific Container in a Pod**
```bash
kubectl logs <pod-name> -c <container-name>
```

#### **Streaming Live Logs**
```bash
kubectl logs -f <pod-name>
```

#### **Retrieving Logs from Previous Container Instances**
```bash
kubectl logs <pod-name> --previous
```

### **2. Sidecar Logging Pattern**
- Sidecars are used to collect and forward logs from application containers.
- Commonly used in logging architectures like **EFK (Elasticsearch, Fluentd, Kibana)**.

#### **Example: Sidecar for Log Aggregation**
```yaml
apiVersion: v1
kind: Pod
metadata:
  name: log-collector-pod
spec:
  containers:
  - name: app-container
    image: nginx
    volumeMounts:
    - name: logs
      mountPath: /var/log/nginx
  - name: sidecar-logger
    image: fluentd
    volumeMounts:
    - name: logs
      mountPath: /var/log/nginx
  volumes:
  - name: logs
    emptyDir: {}
```

---
