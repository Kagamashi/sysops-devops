
## Secret Store CSI Driver in AKS

### What is Secret Store CSI Driver?
The **Secret Store CSI Driver** allows Kubernetes workloads to securely retrieve secrets from **Azure Key Vault** and other external secret management systems. It integrates seamlessly with **Azure Kubernetes Service (AKS)** to provide secure and dynamic secret management.

### Steps to Use Secret Store CSI Driver in AKS

#### Step 1: Enable the Feature in AKS
Run the following command to enable the **Azure Key Vault provider** for Secret Store CSI Driver in AKS:
```sh
az aks enable-addons --addons azure-keyvault-secrets-provider --resource-group <resource-group> --name <aks-cluster>
```

#### Step 2: Create a SecretProviderClass for Azure Key Vault
```yaml
apiVersion: secrets-store.csi.x-k8s.io/v1
kind: SecretProviderClass
metadata:
  name: azure-keyvault-secret-provider
  namespace: default
spec:
  provider: azure
  parameters:
    usePodIdentity: "false"
    clientID: "<your-managed-identity-client-id>"
    keyvaultName: "<your-keyvault-name>"
    objects:  |
      array:
        - objectName: "my-secret"
          objectType: secret
    tenantId: "<your-tenant-id>"
```

#### Step 3: Deploy a Pod That Uses the Secret
```yaml
apiVersion: v1
kind: Pod
metadata:
  name: app-with-azure-keyvault-secret
spec:
  containers:
    - name: app
      image: nginx
      volumeMounts:
        - name: secrets-store
          mountPath: "/mnt/secrets-store"
          readOnly: true
  volumes:
    - name: secrets-store
      csi:
        driver: secrets-store.csi.k8s.io
        readOnly: true
        volumeAttributes:
          secretProviderClass: "azure-keyvault-secret-provider"
```

### Why Use Secret Store CSI Driver in AKS?
✅ **Avoids Storing Secrets in Kubernetes** → Reduces risk of exposure.  
✅ **Integrates with Azure Key Vault** → Securely fetch secrets dynamically.  
✅ **Ephemeral Secrets** → Prevents long-lived secrets in storage.  

---
