
## **Monitoring with Prometheus & Grafana**

### **1. Prometheus (Time-Series Metrics Collection)**
- Collects, stores, and queries metrics from Kubernetes components.
- Works with **Alertmanager** for alerting.

#### **Deploying Prometheus in Kubernetes**
```bash
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm install prometheus prometheus-community/kube-prometheus-stack
```

#### **Checking Prometheus Targets**
```bash
kubectl port-forward svc/prometheus-server 9090:9090 -n monitoring
```
Access **Prometheus UI** at `http://localhost:9090`.

### **2. Grafana (Visualization & Dashboards)**
- Provides real-time monitoring dashboards for Kubernetes metrics.
- Uses Prometheus as a data source.

#### **Deploying Grafana in Kubernetes**
```bash
helm install grafana grafana/grafana --namespace monitoring
```

#### **Accessing Grafana**
```bash
kubectl port-forward svc/grafana 3000:3000 -n monitoring
```
Access **Grafana UI** at `http://localhost:3000`.

---
