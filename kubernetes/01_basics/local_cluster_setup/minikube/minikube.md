

https://minikube.sigs.k8s.io/docs/start/?arch=%2Fmacos%2Farm64%2Fstable%2Fbinary+download

---

## **Minikube**
- Runs a single-node Kubernetes cluster inside a VM or on bare metal.
- Supports multiple drivers (Docker, VirtualBox, KVM, HyperKit, etc.).
- Ideal for local development and testing.

### **Installation & Setup:**
```bash
curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
sudo install minikube-linux-amd64 /usr/local/bin/minikube
```

### **Start a Cluster:**
```bash
minikube start --driver=docker
```

### **Common Issues:**
- Ensure **VT-x/AMD-v** virtualization is enabled in BIOS.
- If using Docker, ensure the Docker daemon is running.

---
