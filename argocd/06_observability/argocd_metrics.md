**# Monitoring and Metrics in ArgoCD**

## Exposed Metrics for Prometheus/Grafana

ArgoCD exposes metrics that can be collected and visualized using Prometheus and Grafana.

### **Prometheus Metrics Endpoint**
- The `/metrics` endpoint provides detailed application insights.
- Example Prometheus scrape config:
  ```yaml
  scrape_configs:
    - job_name: "argocd"
      metrics_path: "/metrics"
      static_configs:
        - targets: ["argocd-metrics-service.argocd.svc.cluster.local:8082"]
  ```

### **Key Metrics to Monitor**
- **Application Health:**
  ```yaml
  expr: count(argocd_app_info)
  legendFormat: "Total Applications"
  ```
- **Sync Status:**
  ```yaml
  expr: sum(rate(argocd_app_sync_total{phase="Succeeded"}[5m]))
  legendFormat: "Sync Success Rate"
  ```
- **Failed Sync Events:**
  ```yaml
  expr: sum(rate(argocd_app_sync_total{phase="Failed"}[5m]))
  legendFormat: "Sync Failures"
  ```
- **Deployment Frequency:**
  ```yaml
  expr: sum(rate(argocd_app_sync_total[1h]))
  legendFormat: "Deployments per Hour"
  ```

## Basic Dashboards to Track App Status and Sync Failures

Grafana dashboards can be used to track:
- **Application sync status (healthy, degraded, out-of-sync)**
- **Sync failure rates and trends over time**
- **Deployment frequencies and rollback counts**

### **Example Grafana Panel for Sync Failures**
```yaml
  expr: sum(rate(argocd_app_sync_total{phase="Failed"}[5m]))
  legendFormat: "Sync Failures"
```

By integrating ArgoCD metrics with Prometheus and Grafana, teams can proactively monitor application health, track failures, and optimize deployments.

---
