
## **Managing API Tokens for External Issuers**
If using **Vault, Venafi, or other external issuers**, Cert-Manager needs authentication tokens.

### **Example: Vault Authentication Secret**
```sh
kubectl create secret generic vault-secret \
  --namespace cert-manager \
  --from-literal=token=<VAULT_TOKEN>
```

#### **Referencing the Secret in a Vault Issuer**
```yaml
apiVersion: cert-manager.io/v1
kind: ClusterIssuer
metadata:
  name: vault-issuer
spec:
  vault:
    server: "https://vault.example.com"
    path: "pki/sign/example-dot-com"
    auth:
      tokenSecretRef:
        name: vault-secret
        key: token
```
> **Tip:** Use Kubernetes **Service Accounts and RBAC** instead of long-lived Vault tokens where possible.

### **Best Practices for API Tokens:**
- **Rotate credentials regularly** (automate using Kubernetes Jobs if needed).
- Use **least privilege access** for authentication tokens.
- Avoid storing credentials in ConfigMaps (use Secrets instead).

---
