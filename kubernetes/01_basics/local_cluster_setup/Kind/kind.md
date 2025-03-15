
https://kind.sigs.k8s.io/

---

## **Kind (Kubernetes-in-Docker)**
- Creates Kubernetes clusters using Docker containers.
- Lightweight, fast to set up, and designed for testing Kubernetes components.
- Preferred for CI/CD and Kubernetes testing environments.

### **Installation & Setup:**
```bash
curl -Lo ./kind https://kind.sigs.k8s.io/dl/latest/kind-linux-amd64
chmod +x ./kind
sudo mv ./kind /usr/local/bin/kind
```

### **Create a Cluster:**
```bash
kind create cluster --name my-cluster
```

### **Common Issues:**
- Ensure Docker is running before creating a cluster.
- Requires Kubernetes **kubectl** to interact with the cluster.

---
