
## **Azure Key Vault**

### **Overview**
Azure Key Vault (AKV) is a **cloud-based secrets management service** that allows secure storage, management, and retrieval of sensitive information such as **API keys, passwords, certificates, and encryption keys**. It integrates natively with **Azure Kubernetes Service (AKS)** and other Azure services.

### **Key Features**
- **Secure Secret Storage**: Encrypts secrets at rest using Azure-managed HSM-backed encryption.
- **Role-Based Access Control (RBAC)**: Fine-grained access permissions with Azure Active Directory (AAD).
- **Automatic Secret Rotation**: Supports expiration policies and automatic updates.
- **Integration with AKS**: Easily inject secrets into Kubernetes workloads.
- **Audit Logging**: Tracks secret access and modifications for security compliance.
- **Certificate and Key Management**: Stores and manages TLS certificates and cryptographic keys.

### **Deploying Azure Key Vault with Kubernetes**
Azure Key Vault can be integrated with Kubernetes using **Azure Key Vault Provider for Secrets Store CSI Driver**.

#### **Step 1: Install the Azure Key Vault CSI Driver**
```bash
kubectl apply -f https://raw.githubusercontent.com/Azure/secrets-store-csi-driver-provider-azure/main/deployment/secretproviderclass.yaml
```

#### **Step 2: Create an Azure Key Vault and Store a Secret**
```bash
az keyvault create --name myKeyVault --resource-group myResourceGroup --location eastus
az keyvault secret set --vault-name myKeyVault --name my-secret --value "super-secret-value"
```

#### **Step 3: Define a SecretProviderClass in Kubernetes**
```yaml
apiVersion: secrets-store.csi.x-k8s.io/v1
kind: SecretProviderClass
metadata:
  name: azure-keyvault-secrets
spec:
  provider: azure
  parameters:
    usePodIdentity: "false"
    keyvaultName: "myKeyVault"
    objects:  |
      array:
        - objectName: "my-secret"
          objectType: "secret"
    tenantId: "<your-tenant-id>"
```

#### **Step 4: Mount the Secret in a Pod**
```yaml
apiVersion: v1
kind: Pod
metadata:
  name: app-pod
spec:
  containers:
  - name: app-container
    image: my-app:latest
    volumeMounts:
    - name: secrets-store
      mountPath: "/mnt/secrets"
      readOnly: true
  volumes:
  - name: secrets-store
    csi:
      driver: secrets-store.csi.k8s.io
      readOnly: true
      volumeAttributes:
        secretProviderClass: "azure-keyvault-secrets"
```

### **Benefits of Using Azure Key Vault with Kubernetes**
- **Centralized Secret Management**: Manages secrets outside Kubernetes for better security.
- **Automatic Secret Sync**: Updates Kubernetes secrets dynamically from AKV.
- **Reduced Attack Surface**: Secrets are not stored in Kubernetes etcd, minimizing exposure.
- **Audit and Compliance**: Integrates with **Azure Monitor** and **Security Center** for logging and governance.

---
