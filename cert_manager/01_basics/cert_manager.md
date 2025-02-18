# Cert-Manager: Core Concepts and Architecture

## **1. Introduction to Cert-Manager**
Cert-Manager is a Kubernetes-native tool used for **automating certificate management**. It integrates with Kubernetes clusters to issue and renew TLS certificates from multiple sources, such as Let's Encrypt, HashiCorp Vault, and private CAs.

### **Key Features:**
- Automates **requesting, renewing, and managing TLS certificates**.
- Supports multiple **certificate authorities (CAs)**.
- Uses Kubernetes **Custom Resource Definitions (CRDs)** to define certificate-related objects.
- Ensures security by automatically rotating expired certificates.
- Works seamlessly with **Ingress controllers**, **Service Meshes**, and other Kubernetes resources.

---

## **2. How Cert-Manager Integrates with Kubernetes**
Cert-Manager extends Kubernetes using **CRDs** that define certificate-related objects. It acts as a **controller** that continuously monitors and manages certificates.

### **Cert-Manager’s Workflow:**
1. A user defines an **Issuer** or **ClusterIssuer** that configures how certificates should be issued.
2. A **Certificate** resource is created, specifying the **domain names, issuer, and duration**.
3. Cert-Manager requests a certificate from the specified **CA (e.g., Let's Encrypt)**.
4. Cert-Manager automatically stores the certificate in a **Kubernetes Secret**.
5. The certificate is **renewed automatically** before expiration.

---

## **3. Cert-Manager CRDs (Custom Resource Definitions)**
Cert-Manager introduces several CRDs to Kubernetes that define certificate-related configurations.

### **Issuer** and **ClusterIssuer**
- **Issuer**: Defines how certificates are issued **within a single namespace**.
- **ClusterIssuer**: A cluster-wide version of `Issuer` that can be used across multiple namespaces.

#### **Example: Let’s Encrypt HTTP-01 Issuer**
```yaml
apiVersion: cert-manager.io/v1
kind: ClusterIssuer
metadata:
  name: letsencrypt-prod
spec:
  acme:
    email: user@example.com
    server: https://acme-v02.api.letsencrypt.org/directory
    privateKeySecretRef:
      name: letsencrypt-prod
    solvers:
      - http01:
          ingress:
            class: nginx
```

### **Certificate**
Defines the **domains, duration, secret storage, and issuer** for a TLS certificate.
#### **Example: Requesting a Certificate**
```yaml
apiVersion: cert-manager.io/v1
kind: Certificate
metadata:
  name: my-tls-cert
  namespace: default
spec:
  secretName: my-tls-secret
  issuerRef:
    name: letsencrypt-prod
    kind: ClusterIssuer
  dnsNames:
    - example.com
    - www.example.com
```
- Cert-Manager **requests a TLS certificate** from Let's Encrypt.
- The issued certificate is **stored in the `my-tls-secret` Kubernetes secret**.
- Cert-Manager **renews the certificate automatically** before expiration.

### **CertificateRequest**
- Represents a **request for a certificate**, typically created automatically when a `Certificate` resource is defined.
- Cert-Manager **signs the request and stores the generated certificate**.

### **Order and Challenge**
- Used internally by Cert-Manager to handle **ACME (Let's Encrypt) certificate issuance**.
- `Order` tracks the request, while `Challenge` ensures **domain ownership verification**.

---

## **4. Cert-Manager’s Role in Kubernetes Security**
Cert-Manager plays a **crucial role in securing Kubernetes workloads**:
- Provides **TLS encryption** for Ingress controllers (NGINX, Traefik, Istio).
- Enables **mTLS (mutual TLS) communication** for microservices.
- Simplifies **certificate lifecycle management**, avoiding manual renewal.
- Ensures **compliance** with security policies by enforcing encrypted traffic.

### **Example: Securing an NGINX Ingress with Cert-Manager**
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

---

## **5. Best Practices for Using Cert-Manager**
| Best Practice | Benefit |
|--------------|---------|
| **Use `ClusterIssuer` for centralized certificate management** | Simplifies certificate handling across multiple namespaces. |
| **Enable ACME DNS-01 challenge for wildcard certificates** | Allows issuance of `*.example.com` certificates. |
| **Monitor certificate expiration** | Use `kubectl get certificate` to track validity. |
| **Use Kubernetes Secrets for storing certificates** | Secure and integrate with applications easily. |
| **Rotate secrets regularly** | Improves security and compliance.

For more details, visit **[Cert-Manager Documentation](https://cert-manager.io/docs/)**.
