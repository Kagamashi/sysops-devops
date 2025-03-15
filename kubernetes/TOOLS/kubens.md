# KUBENS: Kubernetes Namespace Switcher

## **Overview**  
`kubens` is a command-line tool that allows users to **quickly switch between Kubernetes namespaces** without needing to specify the `-n <namespace>` flag in every `kubectl` command. It is part of the **kubectx** toolset and helps streamline namespace management for developers and cluster operators.

---

## **Installation**  
You can install `kubens` using `brew`, `apt`, or manually:

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

### **1. List Available Namespaces**  
```bash
kubens
```
Output example:
```
default
dev
staging
production
```

### **2. Switch to a Namespace**  
```bash
kubens dev
```
This switches the active namespace to **dev**, allowing you to run `kubectl` commands **without specifying `-n dev`**.

### **3. Check Current Namespace**  
```bash
kubens
```
The currently selected namespace is highlighted.

### **4. Reset to Default Namespace**  
```bash
kubens default
```

### **5. Use in a Single Command**  
You can run commands in a different namespace **without switching permanently**:
```bash
kubens dev && kubectl get pods
```

---
