# Kubernetes Resource Limits and Requests

## **Understanding CPU and Memory Requests vs Limits**
Kubernetes allows Pods to specify **resource requests** (minimum guaranteed resources) and **limits** (maximum allowed resources) for CPU and memory. These settings ensure fair resource allocation and prevent a single Pod from consuming excessive cluster resources.

### **Resource Requests**
- **Defines the minimum amount of CPU/memory** that a container is guaranteed.
- The Kubernetes scheduler uses this value to **decide** where to place the Pod.
- If a Node doesn’t have enough requested resources, the Pod won’t be scheduled.

### **Resource Limits**
- **Defines the maximum amount of CPU/memory** a container can use.
- If the Pod exceeds its memory limit, it is **killed (OOMKilled)**.
- If the Pod exceeds its CPU limit, it is **throttled** (CPU capping but not killed).

---

## **Example: Setting Resource Requests and Limits**
```yaml
apiVersion: v1
kind: Pod
metadata:
  name: resource-limits-example
spec:
  containers:
  - name: my-app
    image: nginx
    resources:
      requests:
        cpu: "250m"       # 0.25 CPU cores (millicores)
        memory: "128Mi"   # 128 MiB of memory
      limits:
        cpu: "500m"       # 0.5 CPU cores max
        memory: "256Mi"   # 256 MiB max
```

### **Key Concepts**
| Term | Description |
|------|-------------|
| **CPU Requests** | The amount of CPU reserved for a container. 1 CPU = 1 core, `250m` = 0.25 cores. |
| **Memory Requests** | The amount of memory guaranteed to a container. `128Mi` = 128 megabytes. |
| **CPU Limits** | The max CPU a container can consume. Exceeding this **throttles** the Pod. |
| **Memory Limits** | The max memory a container can consume. Exceeding this causes **OOMKills**. |

---

## **Best Practices for Capacity Planning**

### **1. Set Realistic Resource Requests**
- Avoid setting too **low requests**, as it may cause scheduling inefficiencies.
- Use **historical usage data** to define appropriate resource requests.
- Example: Use `kubectl top pods` to monitor current resource usage:
  ```bash
  kubectl top pods --containers
  ```

### **2. Define Limits to Prevent Resource Overuse**
- Set limits based on expected workload performance.
- **CPU overuse leads to throttling**, while **memory overuse leads to OOM kills**.

### **3. Use Vertical and Horizontal Pod Autoscaling**
- **Horizontal Pod Autoscaler (HPA)**: Adjusts the number of Pods based on CPU/memory usage.
  ```bash
  kubectl autoscale deployment my-app --cpu-percent=50 --min=2 --max=10
  ```
- **Vertical Pod Autoscaler (VPA)**: Adjusts requests and limits dynamically based on actual usage.
  ```yaml
  apiVersion: autoscaling.k8s.io/v1
  kind: VerticalPodAutoscaler
  metadata:
    name: vpa-example
  spec:
    targetRef:
      apiVersion: "apps/v1"
      kind: Deployment
      name: my-app
    updatePolicy:
      updateMode: "Auto"
  ```

### **4. Monitor and Adjust Resource Allocation**
- Use **Prometheus & Grafana** for real-time monitoring.
- Analyze CPU and memory trends to adjust resource settings over time.

### **5. Use Resource Quotas to Enforce Limits**
- Resource quotas **restrict how much CPU/memory a namespace can use**.
- Example: Setting namespace-level resource quotas:
  ```yaml
  apiVersion: v1
  kind: ResourceQuota
  metadata:
    name: namespace-quota
    namespace: my-namespace
  spec:
    hard:
      requests.cpu: "2"
      requests.memory: "4Gi"
      limits.cpu: "4"
      limits.memory: "8Gi"
  ```

### **6. Use LimitRanges for Fine-Grained Control**
- **LimitRanges** define default CPU/memory requests and limits for all Pods in a namespace.
- Example: Setting default resource requests and limits:
  ```yaml
  apiVersion: v1
  kind: LimitRange
  metadata:
    name: default-limits
    namespace: my-namespace
  spec:
    limits:
    - default:
        cpu: "500m"
        memory: "256Mi"
      defaultRequest:
        cpu: "250m"
        memory: "128Mi"
      type: Container
  ```

---

## **Summary: Best Practices for Managing Resource Requests and Limits**
| Best Practice | Benefit |
|--------------|---------|
| **Set realistic resource requests** | Ensures Pods are scheduled efficiently. |
| **Define appropriate limits** | Prevents Pods from consuming excessive CPU/memory. |
| **Use HPA & VPA** | Scales workloads dynamically based on real-time demand. |
| **Monitor resource usage** | Identifies inefficiencies and optimizes capacity planning. |
| **Enforce resource quotas & LimitRanges** | Ensures fair resource distribution across namespaces. |

By properly configuring **resource requests, limits, and autoscaling**, Kubernetes clusters achieve **optimal performance, stability, and cost-efficiency**.

