# KUBECTX: Kubernetes Context Switcher

## **Overview**  
`kubectx` is a command-line tool that allows users to **quickly switch between Kubernetes contexts**. This is useful when working with multiple clusters or environments, such as **development, staging, and production clusters**. `kubectx` helps streamline cluster management by avoiding the need to manually set contexts using long `kubectl config use-context` commands.

---

## **Installation**  
You can install `kubectx` using `brew`, `apt`, or manually:

### **Using Homebrew (macOS/Linux):**  
```bash
brew install kubectx
```

### **Using apt (Debian/Ubuntu):**  
```bash
sudo apt install kubectx
```

### **Manual Installation:**  
```bash
curl -LO https://github.com/ahmetb/kubectx/releases/latest/download/kubectx
chmod +x kubectx
sudo mv kubectx /usr/local/bin/
```

---

## **Basic Usage**  

### **1. List Available Contexts**  
```bash
kubectx
```
Output example:
```
dev-cluster
staging-cluster
prod-cluster *
```
The `*` indicates the currently active context.

### **2. Switch to a Different Kubernetes Context**  
```bash
kubectx dev-cluster
```
This switches the active Kubernetes context to **dev-cluster**.

### **3. Check the Current Context**  
```bash
kubectl config current-context
```

### **4. Rename a Kubernetes Context**  
```bash
kubectx old-name=new-name
```
This renames a context for better readability.

### **5. Delete an Unused Context**  
```bash
kubectx -d old-cluster
```

### **6. Use in a Single Command Without Switching Permanently**  
```bash
kubectx dev-cluster && kubectl get nodes
```

---
