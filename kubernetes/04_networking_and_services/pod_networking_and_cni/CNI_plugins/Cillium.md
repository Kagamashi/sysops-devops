
## **Cilium CNI Plugin**

### **Overview**
Cilium is a high-performance **eBPF-based** CNI plugin that provides **networking, security, and observability** for Kubernetes workloads. Unlike traditional CNI plugins, Cilium leverages **eBPF (Extended Berkeley Packet Filter)** to enforce network policies, monitor network flows, and optimize packet processing at the kernel level.

### **Key Features**
- **eBPF-based Packet Processing**: Enhances performance by bypassing iptables and processing packets directly in the kernel.
- **L3/L4/L7 Network Policies**: Allows filtering at multiple layers (IP, TCP/UDP, HTTP/gRPC, DNS, Kafka).
- **Encryption Support**: Uses **WireGuard** or IPsec for secure in-cluster communication.
- **Transparent Service Load Balancing**: Replaces kube-proxy for direct and efficient service-to-service routing.
- **Deep Observability**: Integrates with Prometheus, Grafana, and Hubble for detailed network insights.
- **Multi-Cluster Support**: Enables communication across multiple Kubernetes clusters.

### **How Cilium Works**
1. **Pod Networking**: Assigns unique IPs to Pods and routes traffic efficiently without iptables.
2. **Policy Enforcement**: Implements **identity-aware network policies** based on Kubernetes labels.
3. **Observability**: Captures detailed network telemetry using Hubble.
4. **Performance Optimization**: Reduces latency and CPU usage compared to traditional CNIs.

### **Cilium Network Policy Example**
```yaml
apiVersion: "cilium.io/v2"
kind: CiliumNetworkPolicy
metadata:
  name: enforce-layer7-policy
  namespace: default
spec:
  endpointSelector:
    matchLabels:
      app: frontend
  ingress:
  - fromEndpoints:
    - matchLabels:
        app: backend
    toPorts:
    - ports:
      - port: "80"
        protocol: TCP
      rules:
        http:
        - method: GET
          path: "/api"
```

### **Installing Cilium**
Deploy Cilium using Helm:
```bash
helm repo add cilium https://helm.cilium.io/
helm install cilium cilium/cilium --namespace kube-system
```

Verify installation:
```bash
kubectl get pods -n kube-system | grep cilium
```

### **When to Use Cilium?**
- For **high-performance networking** in large Kubernetes clusters.
- To **replace kube-proxy** with more efficient eBPF-based service routing.
- When **advanced security policies** are needed at Layer 3, 4, and 7.
- To enable **real-time network observability** with Hubble.
- For **multi-cluster networking** in hybrid cloud environments.

---
