https://github.com/smarter-project/smarter-device-manager/tree/main/charts/smarter-device-manager/templates

---

# Smarter Device Manager for Kubernetes

## Overview
**Smarter Device Manager (SDM)** is an advanced Kubernetes device plugin designed to improve the management of hardware devices (such as GPUs, FPGAs, and NICs) by extending the Kubernetes device plugin framework. It enables efficient resource allocation and utilization of heterogeneous hardware.

## Key Features
- **Dynamic Device Discovery**: Automatically detects hardware devices without requiring a node reboot.
- **Fine-Grained Resource Allocation**: Allows assigning devices based on specific criteria such as NUMA affinity, performance metrics, or custom labels.
- **Multi-Tenant Support**: Facilitates device sharing across multiple pods or namespaces.
- **Extended Device Metadata**: Provides additional details such as topology, usage statistics, and availability.
- **Compatibility**: Works alongside Kubernetes' native device plugins and third-party solutions.

## How It Works
Smarter Device Manager runs as a DaemonSet on each Kubernetes node, where it:
1. **Discovers** devices available on the node.
2. **Registers** these devices with the Kubernetes API.
3. **Manages** the allocation of devices based on pod scheduling requests.
4. **Ensures** that resource constraints and sharing policies are enforced.

## Installation
### Prerequisites
- Kubernetes cluster (v1.18+ recommended)
- Node Feature Discovery (optional, for enhanced topology awareness)

### Deploying SDM
1. Clone the repository:
   ```sh
   git clone https://github.com/your-org/smarter-device-manager.git
   cd smarter-device-manager
   ```
2. Deploy as a DaemonSet:
   ```sh
   kubectl apply -f deploy/sdm-daemonset.yaml
   ```
3. Verify that the SDM DaemonSet is running:
   ```sh
   kubectl get pods -n kube-system -l app=smarter-device-manager
   ```

## Usage
### Listing Available Devices
Once deployed, list detected devices using:
```sh
kubectl get devices -n kube-system
```

### Requesting a Device in a Pod
To request a specific device, add the following to your pod specification:
```yaml
apiVersion: v1
kind: Pod
metadata:
  name: example-device-pod
spec:
  containers:
  - name: example-container
    image: your-image
    resources:
      limits:
        smarterdevices/example-device: 1
```

## Monitoring and Debugging
- Check SDM logs:
  ```sh
  kubectl logs -n kube-system -l app=smarter-device-manager
  ```
- Inspect allocated devices:
  ```sh
  kubectl describe nodes | grep smarterdevices
  ```
