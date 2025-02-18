# OpenTelemetry Contexts and Propagation

## **1. What is Context Propagation?**
Context propagation ensures that **traces, metrics, and logs** are correctly correlated across distributed systems. It enables tracing requests **end-to-end** across microservices and external dependencies.

### **Why is Context Propagation Important?**
- Links **spans** across service boundaries.
- Ensures **consistent telemetry** across distributed systems.
- Helps debug **latency issues and failures** in microservices.
- Supports **vendor-agnostic tracing** (e.g., Azure Monitor, Jaeger, Prometheus).

---

## **2. W3C Trace Context Standard**
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

## **3. Context Propagation in OpenTelemetry**
### **Propagation Mechanisms**
OpenTelemetry provides **propagators** to extract and inject trace context across services.

#### **Propagation in Python**
```python
from opentelemetry.propagate import extract, inject
from opentelemetry.trace import get_tracer

tracer = get_tracer("example-service")
carrier = {"traceparent": "00-4bf92f3577b34da6a3ce929d0e0e4736-00f067aa0ba902b7-01"}
context = extract(carrier)

with tracer.start_as_current_span("operation", context=context):
    inject(carrier)  # Pass context to the next request
```

#### **Propagation in Go**
```go
import (
    "go.opentelemetry.io/otel/propagation"
)

prop := propagation.TraceContext{}
ctx := prop.Extract(context.Background(), carrier)
prop.Inject(ctx, carrier)  // Forward context
```

---

## **4. Baggage: Propagating Custom Metadata**
**Baggage** allows applications to attach metadata to a trace and propagate it across requests.

### **Common Use Cases**
- **User Identity:** Attach user ID to logs for debugging.
- **Region Awareness:** Track region-specific requests.
- **Feature Flags:** Pass feature toggle information between services.

### **Baggage Headers**
| Header | Description |
|--------|-------------|
| `baggage` | Contains key-value pairs of contextual metadata. |

#### **Example of a Baggage Header**
```
baggage: userId=12345,region=us-east-1,featureFlag=beta
```

#### **Setting Baggage in Python**
```python
from opentelemetry.baggage import set_baggage, get_baggage

set_baggage("user_id", "12345")
print(get_baggage("user_id"))  # Outputs: 12345
```

---

## **5. Best Practices for Context Propagation**
- **Use W3C Trace Context** for **standardized tracing** across services.
- **Propagate context in all outgoing requests** (HTTP, gRPC, Kafka, etc.).
- **Use baggage sparingly** to avoid bloating request headers.
- **Instrument middleware/libraries** to handle propagation automatically.
- **Validate trace continuity** by checking trace IDs across services.
