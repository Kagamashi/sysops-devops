
### **Control Plane (istiod)**
**Istiod** is the core component that manages the configuration and control of the service mesh. 
- Includes a built-in **Certificate Authority (CA)** for managing mTLS certificates.

It is responsible for:
- **Configuration Management**: Distributes traffic management policies to Envoy proxies.
- **Security**: Issues and rotates TLS certificates for workload-to-workload communication.
- **Service Discovery**: Monitors Kubernetes services and updates proxies accordingly.
- **Telemetry**: Aggregates and sends telemetry data to monitoring tools.
