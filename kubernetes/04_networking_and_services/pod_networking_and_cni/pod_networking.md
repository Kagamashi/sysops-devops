
## **Pod-to-Pod Communication**

- Each Pod in a Kubernetes cluster is assigned a **unique IP address**.
- Pods can communicate directly with each other using these IP addresses, even if they are on different nodes.
- Kubernetes assumes a **flat network model**, meaning:
  - All Pods can reach each other without Network Address Translation (NAT).
  - No IP address conflicts exist within the cluster.

---

## **Pod-to-Service Communication**

Kubernetes Services abstract and expose a group of Pods, providing load balancing and traffic routing.

### Service Types:
1. **ClusterIP** (Default):
   - Exposes the Service on an internal IP, accessible only within the cluster.

2. **NodePort**:
   - Exposes the Service on a static port on each node.

3. **LoadBalancer**:
   - Integrates with cloud providers to expose the Service externally using a load balancer.

### Benefits:
- **Traffic Load Balancing**: Routes traffic to healthy Pods.
- **Decoupling**: Allows stable access to Pods regardless of their lifecycle changes.

---

## **Service Discovery**

Kubernetes provides built-in service discovery, allowing Pods to resolve the DNS name of a Service to its **ClusterIP**.

- Kubernetes runs a DNS resolver (usually **CoreDNS**) within the cluster.
- DNS is the primary method for service discovery.

**Example**:
- Service DNS: `my-service.my-namespace.svc.cluster.local`

---
