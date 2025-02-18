
## **Custom Issuers and External Plugins**
Cert-Manager allows integrating with **custom PKI issuers** and external signing frameworks beyond ACME, Vault, and Venafi.

### **Using a Custom External Issuer**
A custom issuer can be implemented as a **Kubernetes controller** that listens for CertificateRequests and processes them.

#### **Example: Defining a CustomIssuer**
```yaml
apiVersion: cert-manager.io/v1
kind: ClusterIssuer
metadata:
  name: custom-ca-issuer
spec:
  ca:
    secretName: custom-ca-secret
```
- The CA’s private key and certificate must be stored in a **Kubernetes Secret**:
```sh
kubectl create secret tls custom-ca-secret \
  --namespace cert-manager \
  --cert=ca.crt --key=ca.key
```

### **Integrating External Plugins**
Cert-Manager supports plugins for signing requests via:
- **Webhook Issuers**: External services that sign requests via webhooks.
- **Custom Controllers**: Operators handling certificate issuance in specialized environments.

#### **Example: Using a Webhook Issuer**
A webhook issuer allows a third-party signing service to handle certificate issuance.
```yaml
apiVersion: cert-manager.io/v1
kind: ClusterIssuer
metadata:
  name: webhook-issuer
spec:
  webhook:
    groupName: example.com
    server: https://custom-signer.example.com
    caBundle: BASE64_ENCODED_CA_CERT
```
- The webhook service **signs certificate requests and returns signed certificates**.
- Requires a running **custom webhook server** implementing the Cert-Manager API.

---
