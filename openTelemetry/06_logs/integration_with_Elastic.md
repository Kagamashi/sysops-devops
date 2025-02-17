
## **Integrating OpenTelemetry Logs with Elastic Cloud**
Elastic Cloud is a managed **Elasticsearch + Kibana** solution for log analytics. OpenTelemetry supports **OTLP → Elasticsearch integration**.

### **Step 1: Configure OpenTelemetry Collector to Send Logs to Elastic Cloud**
```yaml
exporters:
  elasticsearch:
    endpoints: ["https://your-elastic-cloud-endpoint"]
    username: "your-elastic-username"
    password: "your-elastic-password"
    indices:
      logs: "otel-logs-*"
```

### **Step 2: Define Log Pipeline in OpenTelemetry Collector**
```yaml
service:
  pipelines:
    logs:
      receivers: [otlp]
      processors: [filter/logs, probabilistic_sampler/logs]
      exporters: [elasticsearch]
```

---
