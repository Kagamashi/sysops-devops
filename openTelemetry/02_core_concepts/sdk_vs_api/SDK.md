
### **OpenTelemetry SDK**
- Provides the **actual implementation** of the API.
- Handles **data processing, sampling, and exporting**.
- Offers configuration options for **exporters, processors, and batching**.
- Required to **send telemetry data to a backend**.

| Feature | OpenTelemetry API | OpenTelemetry SDK |
|---------|-------------------|-------------------|
| Purpose | Defines standard interfaces | Implements API functionality |
| Dependency in Libraries | Yes | No |
| Collecting Data | Yes | Yes |
| Processing Data | No | Yes |
| Exporting Data | No | Yes |
| Sampling | No | Yes |
| Configuration | Minimal | Full control |

---

## **Using OpenTelemetry SDK (Processing & Exporting Data)**
The SDK enables full control over telemetry collection and exporting.

### **Example: Using OpenTelemetry SDK (Python)**
```python
from opentelemetry import trace
from opentelemetry.sdk.trace import TracerProvider
from opentelemetry.sdk.trace.export import ConsoleSpanExporter, SimpleSpanProcessor

trace.set_tracer_provider(TracerProvider())
tracer = trace.get_tracer(__name__)

# Add an exporter
trace.get_tracer_provider().add_span_processor(SimpleSpanProcessor(ConsoleSpanExporter()))

with tracer.start_as_current_span("example-operation"):
    print("Processing trace with SDK")
```

---
