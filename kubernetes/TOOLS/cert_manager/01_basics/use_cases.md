
## **Common Use Cases for Cert-Manager**
Cert-Manager is widely used for automating TLS certificate management in Kubernetes environments. Below are its most common use cases.

### **1. TLS Certificates for Kubernetes Ingress**
Cert-Manager seamlessly integrates with **Ingress controllers** (NGINX, Traefik, Istio) to enable HTTPS encryption for applications.
#### **Example: Securing an NGINX Ingress with Cert-Manager**
```yaml
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: my-ingress
  annotations:
    cert-manager.io/cluster-issuer: letsencrypt-prod
spec:
  tls:
    - hosts:
        - example.com
      secretName: my-tls-secret
  rules:
    - host: example.com
      http:
        paths:
          - path: /
            pathType: Prefix
            backend:
              service:
                name: my-service
                port:
                  number: 80
```
- Cert-Manager **automatically provisions and attaches the TLS certificate** to the Ingress.
- The `tls.secretName` matches the `Certificate` resource, ensuring **encrypted HTTPS traffic**.

### **2. Securing Internal Services with Mutual TLS (mTLS)**
Cert-Manager can issue **mutual TLS (mTLS) certificates** for securing internal service communication in a Kubernetes cluster.
#### **Example: Issuing an Internal Certificate for a Service**
```yaml
apiVersion: cert-manager.io/v1
kind: Certificate
metadata:
  name: internal-tls-cert
  namespace: default
spec:
  secretName: internal-tls-secret
  issuerRef:
    name: internal-ca
    kind: Issuer
  dnsNames:
    - my-service.default.svc.cluster.local
```
- Cert-Manager provisions certificates **for internal communication** between services.
- Ideal for **service mesh integrations** like Istio and Linkerd.

### **3. Wildcard Certificates Using ACME DNS-01 Challenge**
Cert-Manager supports **wildcard certificates (`*.example.com`)**, which require the DNS-01 challenge.
#### **Example: DNS-01 Challenge for Wildcard Certificate**
```yaml
apiVersion: cert-manager.io/v1
kind: Certificate
metadata:
  name: wildcard-cert
  namespace: default
spec:
  secretName: wildcard-tls-secret
  issuerRef:
    name: letsencrypt-dns
    kind: ClusterIssuer
  dnsNames:
    - "*.example.com"
```
- DNS-01 validation **proves domain ownership** for wildcard certificate issuance.
- The certificate covers **all subdomains (`*.example.com`)** instead of single domains.

### **4. HashiCorp Vault Integration for Secret Management**
Cert-Manager integrates with **HashiCorp Vault** for signing certificates and secret management.
#### **Example: Using Vault as an Issuer**
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
        name: vault-token
        key: token
```
- Cert-Manager fetches certificates **directly from Vault**.
- Ideal for environments requiring **centralized secret storage**.

---
