## OpenTelemetry

**OpenTelemetry (OTel)** is an open-source observability framework for **traces, metrics, and logs**, providing **vendor-neutral** instrumentation for distributed applications.

- **Official Docs**: [https://opentelemetry.io/docs/](https://opentelemetry.io/docs/)
- **GitHub Repository**: [https://github.com/open-telemetry/opentelemetry-specification](https://github.com/open-telemetry/opentelemetry-specification)
- **Collector Docs**: [https://opentelemetry.io/docs/collector/](https://opentelemetry.io/docs/collector/)
- **Instrumentation Guides**:
  - [Traces](https://opentelemetry.io/docs/concepts/signals/traces/)
  - [Metrics](https://opentelemetry.io/docs/concepts/signals/metrics/)
  - [Logs](https://opentelemetry.io/docs/concepts/signals/logs/)
- **Registry (OTel SDKs & Exporters)**: [https://opentelemetry.io/registry/](https://opentelemetry.io/registry/)

---

### Dictionary

- **Tracing**: Tracks the flow of a request across services.
- **Span**: A unit of work in tracing, representing a single operation.
- **Context Propagation**: Passing trace context (headers, baggage) across service boundaries.
- **Metrics**: Numeric representations of system state over time (counters, histograms, gauges).
- **Logs**: Structured event data used for debugging and diagnostics.
- **Collector**: A service that receives, processes, and exports telemetry data.
- **Exporter**: Sends collected data to observability backends (e.g., Prometheus, Jaeger, Tempo).
- **Instrumentation Library**: Auto or manual SDKs for adding telemetry to applications.

---

### CRDs (Custom Resource Definitions)

OpenTelemetry **introduces CRDs** when deployed in Kubernetes:

1. **OpenTelemetryCollector**  
   Defines and configures an OpenTelemetry **Collector** instance within a Kubernetes cluster.

2. **Instrumentation**  
   Used to enable automatic instrumentation for supported languages like **Java, Python, Node.js, .NET**.

---

### Other

- **Exporters**:
  - **Jaeger** (Tracing)
  - **Prometheus** (Metrics)
  - **Grafana Loki** (Logs)
- **Context Propagation**:
  - Supports **W3C Trace Context**, **Baggage**, and **gRPC metadata**.

---
