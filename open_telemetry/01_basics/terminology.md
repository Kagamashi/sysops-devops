
## **OpenTelemetry Terminology**
Understanding OpenTelemetry’s core concepts is crucial for setting up monitoring.

### **Tracing Concepts**
| Term | Description |
|------|-------------|
| **Tracer** | Component that generates and manages spans in a distributed system. |
| **Span** | A single unit of work within a trace (e.g., an HTTP request, a DB query). |
| **Trace** | A collection of spans representing an end-to-end transaction. |
| **Context Propagation** | Passing trace data across services (W3C Trace Context, B3). |

### **Metrics Concepts**
| Term | Description |
|------|-------------|
| **Meter** | Component responsible for collecting metric data. |
| **Counter** | A cumulative metric that increases over time (e.g., HTTP requests). |
| **Gauge** | A value that fluctuates over time (e.g., memory usage). |
| **Histogram** | A statistical distribution of values (e.g., request latency). |

### **Logs Concepts**
| Term | Description |
|------|-------------|
| **Logger** | Component that records log messages. |
| **Processor** | Processes log entries (batching, filtering). |
| **Exporter** | Sends logs to a backend like Azure Log Analytics. |

### **Collector Components**
| Term | Description |
|------|-------------|
| **Receiver** | Ingests telemetry data (e.g., OTLP, Zipkin, Jaeger). |
| **Processor** | Modifies data (e.g., batching, filtering, sampling). |
| **Exporter** | Forwards telemetry data to monitoring systems. |

---
