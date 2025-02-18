
### **Pull Model (Pull-Based Metrics Scraping)**
- **The backend (e.g., Prometheus) fetches (pulls) metrics from the application on demand.**
- Requires exposing an **HTTP endpoint** with collected metrics.
- Works well with **Prometheus-style monitoring**.

---

## **Configuring Pull-Based Metrics for Prometheus**
Prometheus scrapes metrics by making HTTP GET requests to an exposed `/metrics` endpoint.

### **Example: Exposing Metrics Endpoint (Python Prometheus Exporter)**
```python
from opentelemetry.exporter.prometheus import PrometheusMetricReader
from prometheus_client import start_http_server

start_http_server(8000)  # Start Prometheus metrics endpoint
metric_reader = PrometheusMetricReader()
```

### **Example: OpenTelemetry Collector Configuration for Prometheus**
```yaml
receivers:
  prometheus:
    config:
      scrape_configs:
        - job_name: "my_service"
          static_configs:
            - targets: ["localhost:8000"]
```

---
