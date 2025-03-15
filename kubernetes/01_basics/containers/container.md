## **Containers

Containers are the foundational units in Kubernetes, encapsulating application binaries, dependencies, and environment configurations. Kubernetes supports multiple container runtimes through the **Container Runtime Interface (CRI)**, with **containerd** and **CRI-O** being the most commonly used in production environments.

### **Key Concepts in Container Management**

### **1. Container Images & Layers**
- Images are composed of multiple layers using **UnionFS** (e.g., OverlayFS in containerd).
- Layers are immutable, meaning updates require creating a new image.
- **Image optimization:** Use multi-stage builds (`Dockerfile`) to reduce image size and improve security.

### **2. Building and Pushing Images**
```bash
docker build -t my-image:latest .
docker tag my-image:latest my-registry.com/my-image:latest
docker push my-registry.com/my-image:latest
```

### **3. Container Runtime Support in Kubernetes**
- **containerd:** Lightweight and production-focused, default in Kubernetes (since v1.20+).
- **CRI-O:** Alternative, optimized for Kubernetes workloads.
- **Docker (deprecated from Kubernetes 1.24+):** Requires **dockershim** for compatibility.

### **4. Inspecting Container Details**
```bash
crictl ps       # List running containers
crictl logs <container-id>   # Inspect logs
crictl exec -it <container-id> /bin/sh   # Debug interactively
```

---
