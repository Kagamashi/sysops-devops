
## Installing Kustomize
Kustomize can be installed as a standalone tool, via `kubectl`, or through package managers.

### **1. Standalone Installation**
Kustomize can be downloaded directly from the official GitHub releases:
```sh
curl -s "https://raw.githubusercontent.com/kubernetes-sigs/kustomize/master/hack/install_kustomize.sh" | bash
mv kustomize /usr/local/bin/
```
To verify the installation:
```sh
kustomize version
```

### **2. Installing via Kubectl**
Kustomize is built into `kubectl` starting from version 1.14:
```sh
kubectl kustomize --help
```
However, using `kubectl kustomize` may not include all features available in the standalone version.

### **3. Installing via Package Managers**
For Linux/macOS:
```sh
brew install kustomize
```
For Windows:
```sh
choco install kustomize
```

---
