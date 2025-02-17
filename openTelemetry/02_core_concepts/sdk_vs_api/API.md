
### **OpenTelemetry API**
- Defines standard interfaces for **tracing, metrics, and logs**.
- Provides vendor-agnostic instrumentation.
- Allows libraries and frameworks to collect telemetry data **without requiring a specific implementation**.
- Does **not** process, sample, or export data.

---

## **Using OpenTelemetry API (Instrumentation Only)**
The API allows applications to instrument code **without requiring an SDK**.

### **Example: Using OpenTelemetry API (Python)**
```python
from opentelemetry import trace
tracer = trace.get_tracer("example-app")

with tracer.start_as_current_span("example-operation"):
    print("Performing an operation")
```

---
