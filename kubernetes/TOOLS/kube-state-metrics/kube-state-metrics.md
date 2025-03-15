
Resources:
https://github.com/kubernetes/kube-state-metrics//examples/standard?ref=v2.14.0

---

# Kube-State-Metrics: Kubernetes Resource Monitoring

## **What is Kube-State-Metrics?**
Kube-State-Metrics is a lightweight service that generates detailed metrics about the state of Kubernetes objects. Unlike metrics-server or node exporters, which collect resource usage metrics, Kube-State-Metrics provides insights into the health and status of cluster resources such as Deployments, Pods, Nodes, and more.

## **Key Features**
- **Cluster State Monitoring:** Provides detailed metrics on Kubernetes objects like Pods, Deployments, DaemonSets, and more.
- **Prometheus-Compatible:** Designed to expose metrics in a format that Prometheus can scrape and process.
- **Efficient and Lightweight:** Does not store data itself but serves real-time metrics directly from the Kubernetes API.
- **No Impact on Cluster Performance:** Reads cluster state without modifying it, ensuring minimal resource consumption.
- **Granular Metrics:** Exposes detailed information on desired, available, and current states of Kubernetes objects.

## **How Kube-State-Metrics Works**
1. **Fetches Kubernetes Object States**
   - Periodically queries the Kubernetes API server.
2. **Exposes Metrics**
   - Converts cluster state data into Prometheus metrics.
3. **Allows Prometheus to Scrape Metrics**
   - Prometheus pulls metrics at defined intervals for storage and alerting.

## **Example Metrics Provided**
- **Pod Status Metrics:**
  ```
  kube_pod_status_phase{namespace="default", pod="nginx"} 1
  ```
  - Tracks whether a pod is `Running`, `Pending`, `Failed`, etc.
- **Deployment Replicas:**
  ```
  kube_deployment_status_replicas_available{namespace="default", deployment="nginx"} 3
  ```
  - Shows the number of available replicas.
- **Node Conditions:**
  ```
  kube_node_status_condition{node="node-1", condition="Ready"} 1
  ```
  - Indicates node readiness.

## **Installation**
Kube-State-Metrics can be deployed using Helm or manually via YAML manifests.

### **Helm Installation**
```sh
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm install kube-state-metrics prometheus-community/kube-state-metrics --namespace monitoring
```

### **Manual Deployment via YAML**
```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: kube-state-metrics
  namespace: monitoring
spec:
  replicas: 1
  selector:
    matchLabels:
      app: kube-state-metrics
  template:
    metadata:
      labels:
        app: kube-state-metrics
    spec:
      containers:
      - name: kube-state-metrics
        image: k8s.gcr.io/kube-state-metrics/kube-state-metrics:v2.6.0
        ports:
        - name: http
          containerPort: 8080
```

## **Use Cases**
- **Cluster Health Monitoring:** Provides insight into Kubernetes object statuses.
- **Scaling Observability:** Tracks replica counts and scaling behaviors.
- **Alerting and Automation:** Helps trigger alerts in Prometheus based on cluster state.
- **Capacity Planning:** Monitors resource allocation across Nodes, Pods, and Deployments.

## **Best Practices**
- **Use Prometheus for Scraping:** Kube-State-Metrics does not store metrics, so integrate it with Prometheus.
- **Limit Unnecessary Metrics:** Disable unneeded metrics to optimize performance.
- **Monitor for Performance Impact:** Ensure frequent API calls do not overwhelm the Kubernetes API server.
- **Secure the Metrics Endpoint:** Use RBAC and network policies to restrict access.

## **Conclusion**
Kube-State-Metrics is a powerful tool for gaining visibility into Kubernetes cluster states. By providing real-time metrics in a Prometheus-friendly format, it enhances observability, alerting, and monitoring capabilities for Kubernetes environments.

---
