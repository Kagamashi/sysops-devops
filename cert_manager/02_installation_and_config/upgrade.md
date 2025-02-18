
## **Basic Configuration and Upgrades**
### **Checking Cert-Manager Version**
To check the currently installed version:
```sh
kubectl get deployment -n cert-manager cert-manager -o=jsonpath='{.spec.template.spec.containers[0].image}'
```

### **Upgrading Cert-Manager with Helm**
To upgrade Cert-Manager while keeping existing configurations:
```sh
helm upgrade cert-manager jetstack/cert-manager \
  --namespace cert-manager \
  --set installCRDs=true
```

### **Upgrading Cert-Manager via Manifests**
If using manifests, apply the latest release:
```sh
kubectl apply -f https://github.com/cert-manager/cert-manager/releases/latest/download/cert-manager.yaml
```

### **Helm Default Values and Customization**
Cert-Manager provides default Helm values, which can be customized using a `values.yaml` file.

#### **Example: Custom `values.yaml` File**
```yaml
installCRDs: true
replicaCount: 2
global:
  leaderElection: true
webhook:
  enabled: true
``` 
Install Cert-Manager with the custom values:
```sh
helm upgrade --install cert-manager jetstack/cert-manager \
  --namespace cert-manager \
  -f values.yaml
```

---
