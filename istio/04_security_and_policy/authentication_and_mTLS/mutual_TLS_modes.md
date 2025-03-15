**# Authentication and Mutual TLS (mTLS) in Istio**

## **Enabling Mutual TLS (mTLS) in Istio**
Mutual TLS (mTLS) ensures encrypted and authenticated communication between services within an Istio service mesh. Istio provides three modes:

### **1. STRICT Mode (Full mTLS Enforcement)**
All service-to-service traffic within the mesh must use mTLS. Unauthorized plaintext requests are denied.
```yaml
apiVersion: security.istio.io/v1beta1
kind: PeerAuthentication
metadata:
  name: strict-mtls
  namespace: default
spec:
  mtls:
    mode: STRICT
```

### **2. PERMISSIVE Mode (Allows Both mTLS and Plaintext)**
Services accept both mTLS-secured and plaintext traffic. This is useful for incremental mTLS adoption.
```yaml
apiVersion: security.istio.io/v1beta1
kind: PeerAuthentication
metadata:
  name: permissive-mtls
  namespace: default
spec:
  mtls:
    mode: PERMISSIVE
```

### **3. DISABLE Mode (No mTLS Enforcement)**
Disables mTLS enforcement entirely, allowing plaintext communication.
```yaml
apiVersion: security.istio.io/v1beta1
kind: PeerAuthentication
metadata:
  name: disable-mtls
  namespace: default
spec:
  mtls:
    mode: DISABLE
```

---
