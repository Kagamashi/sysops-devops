
## **W3C Trace Context Standard**
The **W3C Trace Context** is the default propagation format for OpenTelemetry. It defines how trace information is passed between services using HTTP headers.

### **Trace Context Headers**
| Header | Description |
|--------|-------------|
| `traceparent` | Contains trace ID, span ID, and sampling decision. |
| `tracestate` | Stores vendor-specific metadata for enhanced telemetry. |

#### **Example of a Trace Context Header**
```
traceparent: 00-4bf92f3577b34da6a3ce929d0e0e4736-00f067aa0ba902b7-01
```

- `00` → Version.
- `4bf92f3577b34da6a3ce929d0e0e4736` → **Trace ID** (unique per request).
- `00f067aa0ba902b7` → **Span ID** (unique per operation).
- `01` → **Sampled Flag** (01 = sampled, 00 = not sampled).

---
