# K9s: Kubernetes CLI Dashboard

## **Overview**  
`K9s` is a terminal-based **Kubernetes management UI** that provides a powerful and interactive way to navigate, monitor, and troubleshoot Kubernetes clusters. It enhances the Kubernetes CLI experience by providing a real-time view of cluster resources and logs with an intuitive interface.

---

## **Installation**  
You can install `K9s` using Homebrew, Linux package managers, or manually:

### **Using Homebrew (macOS/Linux):**  
```bash
brew install derailed/k9s/k9s
```

### **Using Chocolatey (Windows):**  
```powershell
choco install k9s
```

### **Manual Installation:**  
```bash
curl -Lo k9s.tar.gz https://github.com/derailed/k9s/releases/latest/download/k9s_Linux_x86_64.tar.gz
mkdir -p ~/.local/bin && tar -xzf k9s.tar.gz -C ~/.local/bin
chmod +x ~/.local/bin/k9s
```

---

## **Basic Usage**  

### **1. Launch K9s**  
```bash
k9s
```
This opens the interactive Kubernetes dashboard.

### **2. Navigate Through Resources**  
- `Shift + :` → Open the command prompt
- `:` → View available resources
- `pod` → List all Pods
- `svc` → List all Services
- `deploy` → List all Deployments

### **3. View Pod Logs**  
```bash
l
```
While selecting a Pod, pressing `l` streams logs in real-time.

### **4. Execute Commands in a Pod**  
```bash
e
```
While selecting a Pod, pressing `e` lets you execute a shell inside it.

### **5. Port Forward a Service or Pod**  
```bash
Shift + f
```
Select the Service or Pod to set up a local port forward.

### **6. Filter and Search for Resources**  
```bash
/filter <string>
```
For example, `/filter nginx` will show only resources related to `nginx`.

### **7. Delete a Resource**  
```bash
d
```
Select a resource and press `d` to delete it.

---
