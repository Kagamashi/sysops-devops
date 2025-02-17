
## **Configuring OpenTelemetry with Environment Variables**
OpenTelemetry allows configuration using environment variables.

| Variable | Description |
|----------|-------------|
| `OTEL_EXPORTER_OTLP_ENDPOINT` | Sets the endpoint for OTLP exporter (e.g., `http://localhost:4317`). |
| `OTEL_RESOURCE_ATTRIBUTES` | Defines resource attributes (e.g., `service.name=my-service`). |
| `OTEL_TRACES_SAMPLER` | Configures sampling (e.g., `always_on`, `parent_based`). |
| `OTEL_METRICS_EXPORTER` | Specifies metric exporter (e.g., `prometheus`, `otlp`). |

Example setting environment variables:
```sh
export OTEL_EXPORTER_OTLP_ENDPOINT="http://otel-collector:4317"
export OTEL_RESOURCE_ATTRIBUTES="service.name=myapp,env=production"
export OTEL_TRACES_SAMPLER="parent_based"
```

---
