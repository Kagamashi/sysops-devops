
## **Collecting and Forwarding Logs to OpenTelemetry Collector**
OpenTelemetry logs can be sent to a **centralized OpenTelemetry Collector** for processing and exporting.

### **Example: Exporting Logs via OpenTelemetry Collector (YAML Configuration)**
```yaml
receivers:
  filelog:
    include: ["/var/log/app.log"]
exporters:
  otlp:
    endpoint: "http://otel-collector:4317"
service:
  pipelines:
    logs:
      receivers: [filelog]
      exporters: [otlp]
```

### **Enriching Logs with Resource Attributes**
To add metadata (e.g., service name, environment), use **resource attributes**.

#### **Python Example (Adding Resource Attributes)**
```python
from opentelemetry.sdk.resources import Resource
from opentelemetry.sdk.logs import LoggerProvider

resource = Resource.create({"service.name": "auth-service", "deployment.environment": "production"})
logger_provider = LoggerProvider(resource=resource)
```

#### **Java Example (Resource Attributes for Logs)**
```java
Resource resource = Resource.create(
    Attributes.of(
        AttributeKey.stringKey("service.name"), "auth-service",
        AttributeKey.stringKey("deployment.environment"), "production"
    )
);
LoggerProvider loggerProvider = LoggerProvider.builder().setResource(resource).build();
```

---
