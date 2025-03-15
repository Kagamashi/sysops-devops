
https://microk8s.io/

---

## **MicroK8s**
- A lightweight Kubernetes distribution maintained by Canonical.
- Designed for edge computing and IoT environments.
- Fast to set up and runs on **Linux, macOS, and Windows**.

### **Installation & Setup:**
```bash
sudo snap install microk8s --classic
```

### **Start and Enable Add-ons:**
```bash
microk8s start
microk8s enable dns dashboard ingress
```

### **Common Issues:**
- Ensure `snapd` is installed on your system.
- Use `microk8s.kubectl` instead of `kubectl` to manage the cluster.

---
