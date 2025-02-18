
## **Installing Cert-Manager with YAML Manifests**
If Helm is not available, you can install Cert-Manager using official YAML manifests.

### **Step 1: Apply the Cert-Manager CRDs**
```sh
kubectl apply -f https://github.com/cert-manager/cert-manager/releases/latest/download/cert-manager.crds.yaml
```

### **Step 2: Deploy Cert-Manager Components**
```sh
kubectl apply -f https://github.com/cert-manager/cert-manager/releases/latest/download/cert-manager.yaml
```

### **Step 3: Verify Installation**
```sh
kubectl get pods -n cert-manager
kubectl get crds | grep cert-manager
```

---
