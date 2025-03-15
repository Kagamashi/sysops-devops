## Istio

An open-source **service mesh** solution that provides secure, reliable, and observable communication between microservices.

- **Official Docs**: [https://istio.io/latest/docs/](https://istio.io/latest/docs/)
- **Github Repo**: [https://github.com/istio/istio](https://github.com/istio/istio)
- **Installation Guides**: [https://istio.io/latest/docs/setup/](https://istio.io/latest/docs/setup/)
- **Reference (API, CRDs)**: [https://istio.io/latest/docs/reference/config/](https://istio.io/latest/docs/reference/config/)

---

## Dictionary

- **Service Mesh**: A dedicated infrastructure layer that manages service-to-service communication.
- **Sidecar Proxy**: Istio uses **Envoy** sidecar containers injected alongside each service pod to intercept and control traffic.
- **mTLS (Mutual TLS)**: Encrypts traffic and authenticates both client and server within the mesh.
- **Gateway**: An Istio resource that defines edge proxy configurations (e.g., ingress, egress).
- **VirtualService**: Configures how requests are routed to a service in the mesh.
- **DestinationRule**: Defines policies like load balancing, connection pools, and TLS settings for a service.
- **Telemetry**: Metrics, logs, and tracing collection for monitoring and observability.
- **Security Policies**: Fine-grained access controls (e.g., AuthorizationPolicy, RequestAuthentication).

---

### CRDs (Custom Resource Definitions)

Istio’s functionality is largely driven by **CRDs** in a Kubernetes environment:

1. **VirtualService**  
   Routes traffic to specific subsets or versions of a service.
2. **DestinationRule**  
   Configures load balancing, connection pool, and TLS settings for a service.
3. **Gateway**  
   Manages inbound and outbound (ingress/egress) traffic across the mesh edge.
4. **ServiceEntry**  
   Adds additional entries (external services) to the mesh.
5. **PeerAuthentication**  
   Configures mTLS for workloads in the mesh.
6. **RequestAuthentication**  
   Sets JWT token requirements for request validation.
7. **AuthorizationPolicy**  
   Enforces access control rules (RBAC) for workloads.

---

### Other

- **Common Traffic Management Features**:
  - **Traffic Shifting** (canary releases, A/B testing)
  - **Fault Injection** (delay, abort)
  - **Mirroring** (traffic shadowing)
- **Security**:
  - Automatic **sidecar injection** for mTLS.
  - Policy enforcement with **AuthorizationPolicy**.
- **Observability**:
  - Built-in integration with **Prometheus**, **Grafana**, and **Kiali** for mesh visualization.
- **istioctl Commands**:
  - `istioctl version` – Check Istio CLI and control plane versions.
  - `istioctl dashboard kiali` – Open Kiali dashboard for service mesh visualization.
  - `istioctl analyze` – Analyze configuration for potential issues.
