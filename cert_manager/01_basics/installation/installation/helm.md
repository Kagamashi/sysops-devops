
## **Installing Cert-Manager with Helm**
Helm is the recommended installation method for Cert-Manager.

### **Step 1: Add the Jetstack Helm Repository**
```sh
helm repo add jetstack https://charts.jetstack.io
helm repo update
```

### **Step 2: Install Cert-Manager**
```sh
helm install cert-manager jetstack/cert-manager \
  --namespace cert-manager \
  --create-namespace \
  --set installCRDs=true
```

### **Step 3: Verify Installation**
```sh
kubectl get pods -n cert-manager
kubectl get crds | grep cert-manager
```

---
