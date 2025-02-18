
## **Storing ACME Credentials Securely**
### **ACME Private Key Storage**
Cert-Manager stores **ACME account private keys** as Kubernetes Secrets.

To view existing ACME secrets:
```sh
kubectl get secrets -n cert-manager | grep acme
```

#### **Example: ACME Account Secret (Let’s Encrypt)**
```yaml
apiVersion: v1
kind: Secret
metadata:
  name: acme-private-key
  namespace: cert-manager
type: Opaque
data:
  private-key: BASE64_ENCODED_PRIVATE_KEY
```
> **Note:** Cert-Manager automatically manages ACME secrets when an `Issuer` or `ClusterIssuer` is created.

### **Best Practices for ACME Secrets:**
- Use **RBAC restrictions** to limit access.
- Rotate ACME accounts **only when necessary** (to avoid breaking renewals).
- Use **staging ACME servers** to test configurations before switching to production.

---
