
## **CNI (Container Network Interface)**

Kubernetes uses CNI plugins to provide networking to Pods. These plugins handle networking at the node level, configuring network interfaces and IP addresses for containers.

### Common CNI Plugins:

#### **1. Flannel**
- Lightweight and simple CNI plugin providing a basic overlay network between nodes.
- **Backend**: Uses VXLAN or host-gw for networking.
- **Use Case**: Suitable for small clusters with basic L3 (IP) connectivity and no advanced NetworkPolicy support.

#### **2. Calico**
- Supports BGP (Border Gateway Protocol) for routing traffic without overlays, reducing overhead.
- Fully supports Kubernetes NetworkPolicies and provides its own advanced policy engine.
- **Use Case**: Ideal for large-scale clusters requiring fine-grained network security, scalability, and performance.

#### **3. Weave**
- Provides an overlay network with encryption for secure Pod-to-Pod communication.
- Uses a mesh network to route traffic and integrates with Kubernetes NetworkPolicies.
- **Use Case**: Useful for clusters requiring encryption without external security tools.

#### **4. Cilium**
- Advanced CNI plugin leveraging **eBPF** for efficient packet processing and security.
- Offers L4 (transport) and L7 (application) policies for fine-grained traffic control.
- **Use Case**: High-performance, security-focused environments requiring deep observability and control.

---

## **How CNI Plugins Work**

- **Pod Creation**: When a Pod is created, the kubelet interacts with the CNI plugin to assign an IP address and configure networking.
- **Traffic Management**: CNI plugins assigns IP to the Pod, creates necessary network routes, configure inter-pod connectivity and security rules
- **
- **Pod Deletion**: The CNI plugin cleans up the network configuration when a Pod is deleted.

---
