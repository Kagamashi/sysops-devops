# Cert-Manager: Vault and Other External Issuers

## **1. Introduction to External Issuers**
While Cert-Manager natively supports **Let's Encrypt (ACME)**, it can also integrate with **external PKI solutions**, including:
- **HashiCorp Vault**
- **Venafi**
- **Custom signing solutions using Kubernetes CA APIs**

Using an external issuer allows organizations to use their own **internal certificate authorities (CAs)** while maintaining automated certificate lifecycle management within Kubernetes.

---

## **2. HashiCorp Vault Integration**
HashiCorp Vault is a widely used **secrets management** tool that includes **PKI and certificate management capabilities**.

### **Step 1: Configure Vault for PKI**
First, enable the PKI secrets engine in Vault:
```sh
vault secrets enable pki
vault write pki/root/generate/internal common_name="my-org.com" ttl=87600h
vault write pki/roles/example-dot-com \
  allowed_domains="example.com" \
  allow_subdomains=true \
  max_ttl="72h"
```
This creates a CA that can sign certificates for `example.com` and its subdomains.

### **Step 2: Store Vault Access Credentials in Kubernetes**
Create a Kubernetes secret for Vault authentication:
```sh
kubectl create secret generic vault-secret \
  --namespace cert-manager \
  --from-literal=token=<VAULT_TOKEN>
```

### **Step 3: Define the Vault Issuer in Cert-Manager**
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
- This tells Cert-Manager to **use Vault as an issuer**.
- The Vault authentication token is stored securely in a **Kubernetes secret**.

### **Step 4: Request a Certificate Using Vault**
```yaml
apiVersion: cert-manager.io/v1
kind: Certificate
metadata:
  name: vault-cert
  namespace: default
spec:
  secretName: vault-cert-secret
  issuerRef:
    name: vault-issuer
    kind: ClusterIssuer
  dnsNames:
    - myservice.example.com
```
Cert-Manager will now **request and renew certificates** from Vault automatically.

---

## **3. Using a Custom CA as an Issuer**
Organizations with an existing **internal CA** can integrate it with Cert-Manager.

### **Example: Creating a Custom Kubernetes CA Issuer**
```yaml
apiVersion: cert-manager.io/v1
kind: Issuer
metadata:
  name: custom-ca-issuer
  namespace: default
spec:
  ca:
    secretName: my-ca-secret
```
- The CA private key and certificate must be stored in a Kubernetes secret:
```sh
kubectl create secret tls my-ca-secret \
  --namespace default \
  --cert=ca.crt --key=ca.key
```

### **Requesting a Certificate from a Custom CA**
```yaml
apiVersion: cert-manager.io/v1
kind: Certificate
metadata:
  name: custom-ca-cert
  namespace: default
spec:
  secretName: custom-ca-cert-secret
  issuerRef:
    name: custom-ca-issuer
    kind: Issuer
  dnsNames:
    - myservice.internal
```

---

## **4. Venafi as an Issuer**
For enterprises using **Venafi Trust Protection Platform**, Cert-Manager can be configured as an integration layer.

### **Step 1: Create a Venafi Issuer**
```yaml
apiVersion: cert-manager.io/v1
kind: ClusterIssuer
metadata:
  name: venafi-issuer
spec:
  venafi:
    zone: "MyVenafiZone"
    tpp:
      url: "https://venafi.example.com"
      credentialsRef:
        name: venafi-secret
```
- The Venafi credentials must be stored as a Kubernetes secret:
```sh
kubectl create secret generic venafi-secret \
  --namespace cert-manager \
  --from-literal=username="admin" \
  --from-literal=password="supersecurepassword"
```

### **Step 2: Request a Certificate from Venafi**
```yaml
apiVersion: cert-manager.io/v1
kind: Certificate
metadata:
  name: venafi-cert
  namespace: default
spec:
  secretName: venafi-cert-secret
  issuerRef:
    name: venafi-issuer
    kind: ClusterIssuer
  dnsNames:
    - secure.example.com
```

---

## **5. Best Practices for External Issuers**
| Best Practice | Benefit |
|--------------|---------|
| **Use Kubernetes Secrets for credentials** | Avoids storing sensitive Vault or Venafi credentials in plaintext. |
| **Set up Vault roles with least privilege access** | Limits Cert-Manager’s ability to request unintended certificates. |
| **Regularly rotate CA keys and certificates** | Enhances security and reduces exposure risks. |
| **Monitor certificate expiration and renewal** | Ensures availability of secured services. |

For more details, visit:
- **[Cert-Manager Vault Integration](https://cert-manager.io/docs/configuration/vault/)**
- **[Cert-Manager Venafi Integration](https://cert-manager.io/docs/configuration/venafi/)**
