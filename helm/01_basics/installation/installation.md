
## **Installing Helm**
Helm can be installed on **Linux, macOS, and Windows** using different package managers.

### **Linux Installation**
#### **Using Script (Recommended)**
```sh
curl -fsSL https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash
```

#### **Using Package Managers**
- **APT (Debian/Ubuntu):**
  ```sh
  sudo apt update && sudo apt install helm
  ```
- **YUM (RHEL/CentOS):**
  ```sh
  sudo yum install helm
  ```

### **macOS Installation**
#### **Using Homebrew**
```sh
brew install helm
```

#### **Verifying Installation**
Check the Helm version:
```sh
helm version
```
Expected output (example):
```sh
version.BuildInfo{Version:"v3.10.1", GitCommit:"abc123", ...}
```

---

