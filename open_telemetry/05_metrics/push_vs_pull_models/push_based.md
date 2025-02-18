
### **Push Model (Push-Based Metrics Exporting)**
- **Metrics are sent (pushed) from the application to the backend at regular intervals.**
- Typically used for **cloud-based observability platforms** (e.g., Azure Monitor, Datadog, OTLP exporters).
- Ensures **low-latency metric delivery**.

---

## **Configuring Push-Based Metrics in OpenTelemetry**
Push-based metrics require an **exporter** to send data to an observability backend at regular intervals.

### **Example: Push Model with OTLP Exporter (Python)**
```python
from opentelemetry.sdk.metrics.export import PeriodicExportingMetricReader, OTLPMetricExporter

exporter = OTLPMetricExporter(endpoint="http://otel-collector:4317")
reader = PeriodicExportingMetricReader(exporter, export_interval_millis=10000)  # 10s interval
```

### **Example: Push Model with OpenTelemetry Collector**
```yaml
exporters:
  otlp:
    endpoint: "http://observability-backend:4317"
processors:
  batch:
    timeout: 5s
    send_batch_size: 100
```

---
