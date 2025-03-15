# Kubernetes Alerting and Incident Response

## **Configuring Alerts for Cluster States**
Effective monitoring and alerting are crucial for maintaining Kubernetes cluster health. **Prometheus Alertmanager** is commonly used to send alerts based on predefined conditions.

### **1. Setting Up Prometheus Alertmanager**
**Install Prometheus and Alertmanager:**
```bash
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm install prometheus prometheus-community/kube-prometheus-stack -n monitoring --create-namespace
```

**Check Alertmanager Installation:**
```bash
kubectl get pods -n monitoring | grep alertmanager
```

### **2. Configuring Alert Rules in Prometheus**
Alerts are defined in **PrometheusRule** resources.

#### **Example: Alert for High CPU Usage on Nodes**
```yaml
apiVersion: monitoring.coreos.com/v1
kind: PrometheusRule
metadata:
  name: node-high-cpu
  namespace: monitoring
spec:
  groups:
  - name: node-alerts
    rules:
    - alert: HighNodeCPU
      expr: avg(rate(node_cpu_seconds_total[5m])) by (instance) > 0.9
      for: 5m
      labels:
        severity: critical
      annotations:
        summary: "High CPU usage on {{ $labels.instance }}"
        description: "CPU usage is above 90% for more than 5 minutes."
```

### **3. Configuring Alertmanager for Notifications**
Alertmanager **routes alerts** to various receivers such as **Slack, Email, PagerDuty, and Webhooks**.

#### **Example: Alertmanager Configuration for Slack**
```yaml
apiVersion: v1
kind: ConfigMap
metadata:
  name: alertmanager-config
  namespace: monitoring
  labels:
    app: alertmanager
    component: monitoring
    managed-by: prometheus
data:
  alertmanager.yml: |
    route:
      receiver: "slack"
    receivers:
    - name: "slack"
      slack_configs:
      - channel: "#alerts"
        send_resolved: true
        api_url: "https://hooks.slack.com/services/TOKEN"
```

Apply the configuration:
```bash
kubectl apply -f alertmanager-config.yaml
```

---
