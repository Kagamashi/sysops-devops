
## **ACME and Let's Encrypt**
Cert-Manager supports the **Automated Certificate Management Environment (ACME)** protocol, commonly used with Let's Encrypt.

### **HTTP-01 vs. DNS-01 Challenges**
ACME challenges are used to verify domain ownership before issuing certificates.

| Challenge Type | Description | Use Case |
|---------------|-------------|------------|
| **HTTP-01** | Places a file on an HTTP server for validation | Best for **Ingress-based** certificates |
| **DNS-01** | Creates a DNS TXT record for validation | Required for **wildcard certificates (`*.example.com`)** |

### **Example: HTTP-01 Challenge with Let's Encrypt**
```yaml
apiVersion: cert-manager.io/v1
kind: ClusterIssuer
metadata:
  name: letsencrypt-http
spec:
  acme:
    email: user@example.com
    server: https://acme-v02.api.letsencrypt.org/directory
    privateKeySecretRef:
      name: letsencrypt-http-key
    solvers:
      - http01:
          ingress:
            class: nginx
```
- This configuration **validates domains via HTTP-01**.
- The issued certificate can be used with an **NGINX Ingress controller**.

### **Example: DNS-01 Challenge for Wildcard Certificates**
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
          cloudDNS:
            project: my-gcp-project
```
- This **validates domains using DNS-01**.
- Required for **wildcard domains (`*.example.com`)**.

### **Staging vs. Production ACME Servers**
Let's Encrypt provides both **staging** and **production** endpoints:

| Server Type | URL | Use Case |
|------------|-----|----------|
| **Staging** | `https://acme-staging-v02.api.letsencrypt.org/directory` | Testing without rate limits |
| **Production** | `https://acme-v02.api.letsencrypt.org/directory` | Live certificate issuance |

> **Tip:** Always test certificates using the **staging server** before switching to production.

---
