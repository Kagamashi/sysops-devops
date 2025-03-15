# STERN: Kubernetes Multi-Pod Log Tailing Tool

## **Overview**  
`stern` is a command-line tool that allows users to **tail logs from multiple Kubernetes pods** simultaneously. It enhances `kubectl logs` by supporting log filtering, regex-based pod selection, and color-coded output. This makes it an essential tool for debugging and monitoring applications in Kubernetes.

---

## **Installation**  
You can install `stern` using Homebrew, Linux package managers, or manually:

### **Using Homebrew (macOS/Linux):**  
```bash
brew install stern
```

### **Using Chocolatey (Windows):**  
```powershell
choco install stern
```

### **Manual Installation:**  
```bash
curl -Lo stern https://github.com/stern/stern/releases/latest/download/stern_linux_amd64
chmod +x stern
sudo mv stern /usr/local/bin/
```

---

## **Basic Usage**  

### **1. Tail Logs from All Pods Matching a Name Pattern**  
```bash
stern my-app
```
This will stream logs from all pods with names matching `my-app`.

### **2. Tail Logs from a Specific Namespace**  
```bash
stern my-app -n my-namespace
```

### **3. Filter Logs by Container Name**  
```bash
stern my-app -c my-container
```

### **4. Use Regular Expressions to Match Pods**  
```bash
stern '^backend-.*'
```
This matches all pods with names starting with `backend-`.

### **5. Tail Logs from Multiple Containers in One Pod**  
```bash
stern my-app --all-containers
```

### **6. Display Logs with Timestamps**  
```bash
stern my-app --timestamps
```

### **7. Customize Output Formatting**  
```bash
stern my-app --output=json
```
Supports `default`, `json`, and `raw` output formats.

---
