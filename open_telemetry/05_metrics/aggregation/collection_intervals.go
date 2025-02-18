
## **Setting Collection Intervals**
Collection intervals define how often metrics are recorded and exported.

### **Configuring Collection Interval in OpenTelemetry Collector**
```yaml
receivers:
  otlp:
    protocols:
      grpc:
        collection_interval: 30s  # Collect data every 30 seconds
```

### **Python SDK Example (Setting Export Interval)**
```python
from opentelemetry.sdk.metrics.export import PeriodicExportingMetricReader
reader = PeriodicExportingMetricReader(export_interval_millis=10000)  # 10s interval
```

---
