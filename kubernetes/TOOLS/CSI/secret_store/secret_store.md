
https://secrets-store-csi-driver.sigs.k8s.io/
https://learn.microsoft.com/en-us/azure/aks/csi-secrets-store-driver

---

## Secret Store CSI Driver

### What is Secret Store CSI Driver?
The **Secret Store CSI Driver** allows Kubernetes workloads to securely retrieve secrets from **external secret management solutions** such as HashiCorp Vault, AWS Secrets Manager, Azure Key Vault, and Google Cloud Secret Manager. This eliminates the need for storing secrets in Kubernetes itself, reducing security risks.

### Features of Secret Store CSI Driver
| **Feature** | **Description** |
|------------|------------------------------------------------------|
| **Dynamic Secret Injection** | Automatically mount secrets inside Pods at runtime. |
| **Support for External Vaults** | Fetch secrets from AWS Secrets Manager, Azure Key Vault, GCP Secret Manager, and HashiCorp Vault. |
| **Ephemeral Secrets** | Secrets exist only during Pod runtime and are not stored persistently. |
| **Sync with Kubernetes Secrets** | Optionally sync external secrets into Kubernetes Secrets. |

### Example: Using Secret Store CSI Driver

#### Step 1: Install the Secret Store CSI Driver
```sh
kubectl apply -f https://raw.githubusercontent.com/kubernetes-sigs/secrets-store-csi-driver/main/deploy/rbac-secretproviderclass.yaml
```

#### Step 2: Define a `SecretProviderClass`
```yaml
apiVersion: secrets-store.csi.x-k8s.io/v1alpha1
kind: SecretProviderClass
metadata:
  name: my-secret-provider
  namespace: default
spec:
  provider: aws
  parameters:
    objects: |
      - objectName: "my-secret"
        objectType: "secretsmanager"
```

#### Step 3: Use the Secret in a Pod
```yaml
apiVersion: v1
kind: Pod
metadata:
  name: app-with-secret
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
          secretProviderClass: "my-secret-provider"
```

### Why Use Secret Store CSI Driver?
✅ **Avoids Storing Secrets in Kubernetes** → Reduces risk of exposure.  
✅ **Integrates with Enterprise Secret Vaults** → Works with cloud and on-prem solutions.  
✅ **Ephemeral Secrets** → Prevents long-lived secrets in storage.  

---

