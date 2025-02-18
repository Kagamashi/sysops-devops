
## **Storing DNS Provider Credentials for DNS-01 Challenges**
For **DNS-01 challenges**, Cert-Manager must authenticate with DNS providers (e.g., AWS Route 53, Cloudflare, Google Cloud DNS).

### **Example: Storing Cloudflare API Token in a Kubernetes Secret**
```sh
kubectl create secret generic cloudflare-api-token \
  --namespace cert-manager \
  --from-literal=api-token=<CLOUDFLARE_API_TOKEN>
```

#### **Referencing the Secret in an ACME Issuer (DNS-01 Challenge)**
```yaml
apiVersion: cert-manager.io/v1
kind: ClusterIssuer
metadata:
  name: letsencrypt-dns
spec:
  acme:
    email: user@example.com
    server: https://acme-v02.api.letsencrypt.org/directory
    privateKeySecretRef:
      name: letsencrypt-dns-key
    solvers:
      - dns01:
          cloudflare:
            apiTokenSecretRef:
              name: cloudflare-api-token
              key: api-token
```

### **Best Practices for DNS Provider Credentials:**
- Use **restricted API tokens** (e.g., read/write only for `_acme-challenge` records).
- **Rotate credentials periodically** and update the Secret.
- Restrict access to Secrets via **RBAC policies**.

---
