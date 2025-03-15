
### **Sidecar Proxy Pattern**
**Envoy** is deployed as a sidecar proxy alongside every service in the mesh. It intercepts all incoming and outgoing traffic for the service, applying Istio's traffic rules and security policies, while also collecting telemetry data.

- **Load Balancing**: Distributes traffic across service instances.
- **Fault Tolerance**: Handles retries, failovers, and circuit breaking.
- **Security Enforcement**: Applies mTLS for secure communication.
- **Routing**: Manages traffic routing based on Istio's configurations.

The sidecar model ensures:
- Consistent traffic management and security across the entire mesh.
- No need to modify application code for traffic management or security policies.
