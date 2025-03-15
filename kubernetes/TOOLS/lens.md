# Lens: Kubernetes IDE

## **Overview**  
`Lens` is a powerful **Kubernetes graphical user interface (GUI)** designed for **managing, monitoring, and troubleshooting** Kubernetes clusters. It provides an intuitive **desktop application** that simplifies cluster operations, making it an excellent tool for both developers and operators.

---

## **Installation**  
You can install `Lens` on **Windows, macOS, and Linux**.

### **1. Install via Lens Official Website:**  
Download the latest version from [Lens Official Website](https://k8slens.dev/).

### **2. Install via Homebrew (macOS/Linux):**  
```bash
brew install --cask lens
```

### **3. Install via Snap (Linux):**  
```bash
sudo snap install kontena-lens --classic
```

### **4. Install via Chocolatey (Windows):**  
```powershell
choco install lens
```

---

## **Basic Usage**  

### **1. Open Lens**  
After installation, launch Lens from your desktop or terminal:
```bash
lens
```

### **2. Add a Kubernetes Cluster**  
- Click **+ Add Cluster**.
- Select a **Kubeconfig** file.
- Lens automatically connects to your cluster and visualizes resources.

### **3. Navigate Through Cluster Resources**  
- **Workloads:** View Deployments, StatefulSets, Pods, Jobs, and CronJobs.
- **Networking:** Manage Services, Ingress, and Network Policies.
- **Storage:** Inspect PersistentVolumes and PersistentVolumeClaims.
- **Configuration:** Edit ConfigMaps, Secrets, and RBAC settings.
- **Events:** Track all Kubernetes cluster events in real time.

### **4. View Pod Logs**  
Click on a Pod and navigate to the **Logs** tab to stream real-time logs.

### **5. Execute Shell Inside a Pod**  
Click on a running Pod and select **Terminal** to open a shell session.

### **6. Port Forward a Service**  
- Select a **Service** and click **Port Forward**.
- Lens automatically sets up the tunnel and provides a local URL.

### **7. Apply YAML Manifests**  
Apply configurations directly from the Lens UI:
- Navigate to **Resources > Apply YAML**.
- Paste or load a YAML file and deploy instantly.

---
