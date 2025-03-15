
## **HashiCorp Vault**

### **Overview**
HashiCorp Vault is a **secrets management tool** designed to securely store, manage, and access sensitive information such as **API keys, passwords, tokens, and certificates**. It provides robust encryption, access control, and audit logging to ensure that secrets are protected and accessed only by authorized applications and users.

### **Key Features**
- **Dynamic Secrets**: Automatically generate temporary secrets (e.g., database credentials) that expire after use.
- **Secret Encryption**: Store secrets securely with AES-256 encryption.
- **Access Control Policies**: Enforce granular Role-Based Access Control (RBAC) for secret access.
- **Audit Logging**: Tracks all secret access and modifications.
- **Multi-Cloud & Hybrid Support**: Integrates with AWS, Azure, Google Cloud, and on-premises deployments.
- **Kubernetes Authentication**: Allows Pods to authenticate to Vault using Kubernetes Service Accounts.

### **Deploying HashiCorp Vault on Kubernetes**
Vault can be deployed as a **standalone server** or using the **Helm chart**:
```bash
helm repo add hashicorp https://helm.releases.hashicorp.com
helm install vault hashicorp/vault --namespace vault --create-namespace
```

### **Configuring Vault for Kubernetes Authentication**
1. **Enable Kubernetes authentication in Vault**:
```bash
vault auth enable kubernetes
```
2. **Configure Vault to trust the Kubernetes API Server**:
```bash
vault write auth/kubernetes/config \
    token_reviewer_jwt="$(cat /var/run/secrets/kubernetes.io/serviceaccount/token)" \
    kubernetes_host="https://$KUBERNETES_PORT_443_TCP_ADDR:443" \
    kubernetes_ca_cert=@/var/run/secrets/kubernetes.io/serviceaccount/ca.crt
```
3. **Create a Vault policy to grant access to secrets**:
```hcl
path "secret/data/db-password" {
  capabilities = ["read"]
}
```
4. **Associate the policy with a Kubernetes Service Account**:
```bash
vault write auth/kubernetes/role/my-app \
    bound_service_account_names=my-app-sa \
    bound_service_account_namespaces=default \
    policies=my-app-policy \
    ttl=24h
```

### **Example: Retrieving Secrets from Vault in Kubernetes**
```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: vault-app
spec:
  replicas: 1
  selector:
    matchLabels:
      app: vault-app
  template:
    metadata:
      labels:
        app: vault-app
    spec:
      serviceAccountName: my-app-sa
      containers:
      - name: app
        image: my-app:latest
        env:
        - name: VAULT_ADDR
          value: "http://vault.vault.svc.cluster.local:8200"
        - name: VAULT_TOKEN
          valueFrom:
            secretKeyRef:
              name: vault-token
              key: token
```

### **Benefits of Using Vault for Kubernetes Secrets Management**
- **Centralized Secret Storage**: Keeps secrets outside Kubernetes, reducing security risks.
- **Automatic Secret Rotation**: Prevents stale credentials and enhances security.
- **Fine-Grained Access Control**: Allows tight control over who can access secrets.
- **Enhanced Auditing & Logging**: Provides visibility into secret usage.

---
