
## **Data Plane (Envoy Proxies)**
The **Data Plane** handles the actual traffic between microservices. In Istio, this is managed by **Envoy Proxies** deployed as **sidecars** to application pods. 

They handle:
- **Traffic Routing**: Directs requests based on policies.
- **Load Balancing**: Distributes traffic across service instances.
- **Security Enforcement**: Implements mTLS, authentication, and authorization.
- **Telemetry Collection**: Gathers metrics, logs, and traces for monitoring.
