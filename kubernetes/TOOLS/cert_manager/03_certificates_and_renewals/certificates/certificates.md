# Basic Certificate Definition in Cert-Manager

## **1. Introduction to Certificate Definitions**
Cert-Manager uses the **Certificate** resource to request, issue, and renew TLS certificates automatically. Each certificate is linked to an **Issuer or ClusterIssuer**, which defines how the certificate is obtained.

### **Key Components of a Certificate Definition:**
- **`dnsNames`**: The domain(s) covered by the certificate.
- **`secretName`**: The Kubernetes Secret where the TLS certificate is stored.
- **`issuerRef`**: The reference to the **Issuer** or **ClusterIssuer** responsible for issuing the certificate.
- **`duration` and `renewBefore`**: Optional settings to define certificate validity and renewal timing.

---

## **2. Example: Single-Domain Certificate**
A single-domain certificate is used for a **specific FQDN (e.g., `example.com`)**.

```yaml
apiVersion: cert-manager.io/v1
kind: Certificate
metadata:
  name: example-com-cert
  namespace: default
spec:
  secretName: example-com-tls
  issuerRef:
    name: letsencrypt-prod
    kind: ClusterIssuer
  dnsNames:
    - example.com
  duration: 90d  # Optional: Default is 90 days
  renewBefore: 30d  # Optional: Renew 30 days before expiration
```
### **Explanation:**
- This certificate is issued by **letsencrypt-prod**.
- Covers **`example.com`**.
- The resulting TLS certificate is stored in **`example-com-tls` Secret**.
- Cert-Manager will automatically **renew the certificate** 30 days before expiry.

---

## **3. Example: Multi-Domain (SAN) Certificate**
A certificate can cover **multiple domains** using **Subject Alternative Names (SANs)**.

```yaml
apiVersion: cert-manager.io/v1
kind: Certificate
metadata:
  name: multi-domain-cert
  namespace: default
spec:
  secretName: multi-domain-tls
  issuerRef:
    name: letsencrypt-prod
    kind: ClusterIssuer
  dnsNames:
    - example.com
    - www.example.com
    - api.example.com
```
### **Explanation:**
- This certificate is valid for **`example.com`, `www.example.com`, and `api.example.com`**.
- Useful for securing **multiple subdomains under a single certificate**.

---

## **4. Example: Wildcard Certificate**
A **wildcard certificate** covers all subdomains under a given domain (e.g., `*.example.com`). It requires the **DNS-01 challenge** method.

```yaml
apiVersion: cert-manager.io/v1
kind: Certificate
metadata:
  name: wildcard-cert
  namespace: default
spec:
  secretName: wildcard-tls
  issuerRef:
    name: letsencrypt-dns
    kind: ClusterIssuer
  dnsNames:
    - "*.example.com"
```
### **Explanation:**
- Covers **all subdomains** (`*.example.com`) under the root domain.
- Requires **DNS-01 challenge validation**, so it must be used with a DNS-enabled `ClusterIssuer`.
- Ideal for **dynamic subdomain-based applications**.

---

## **Best Practices for Certificate Management**
| Best Practice | Benefit |
|--------------|---------|
| **Use `ClusterIssuer` for centralized certificate management** | Simplifies certificate issuance across namespaces. |
| **Use wildcard certificates only when necessary** | Reduces certificate management overhead, but increases security exposure. |
| **Set `renewBefore` at least 30 days before expiry** | Ensures timely certificate renewals. |
| **Monitor Cert-Manager logs and events** | Helps debug issues (`kubectl describe certificate <cert-name>`). |
| **Use Kubernetes Secrets for storing private keys** | Prevents unauthorized access to TLS credentials. |

For more details, visit **[Cert-Manager Documentation](https://cert-manager.io/docs/)**.
