## **PeerAuthentication vs RequestAuthentication**
Istio provides two authentication policies for securing service communication:

| Feature               | PeerAuthentication | RequestAuthentication |
|----------------------|-------------------|----------------------|
| **Purpose**          | Secures service-to-service (mTLS) communication | Validates JWT tokens for end-user authentication |
| **Applied to**       | Workloads (service instances) | Incoming HTTP requests |
| **TLS Enforcement**  | Yes (STRICT, PERMISSIVE, DISABLE) | No |
| **JWT Validation**   | No | Yes |
| **Example Usage**    | Enforcing mTLS between services | Ensuring requests contain valid JWT tokens |

### **PeerAuthentication Example (mTLS Enforcement)**
```yaml
apiVersion: security.istio.io/v1beta1
kind: PeerAuthentication
metadata:
  name: default
  namespace: istio-system
spec:
  mtls:
    mode: STRICT
```

### **RequestAuthentication Example (JWT Validation)**
```yaml
apiVersion: security.istio.io/v1beta1
kind: RequestAuthentication
metadata:
  name: jwt-authentication
  namespace: default
spec:
  selector:
    matchLabels:
      app: my-service
  jwtRules:
    - issuer: "https://auth.example.com"
      jwksUri: "https://auth.example.com/.well-known/jwks.json"
```

---
