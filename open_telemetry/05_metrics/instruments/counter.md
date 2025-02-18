
## **Counter (Monotonic Increasing Value)**
- **Use Case:** Counting events (e.g., HTTP requests, database queries).
- **Monotonic** (only increases, cannot decrease).

### **Python Example**
```python
from opentelemetry import metrics
meter = metrics.get_meter("example-app")
request_counter = meter.create_counter("http_requests")
request_counter.add(1, {"route": "/home", "status": "200"})
```

#### **Java Example**
```java
Meter meter = GlobalOpenTelemetry.getMeter("example-app");
LongCounter requestCounter = meter.counterBuilder("http_requests").build();
requestCounter.add(1, Attributes.of(stringKey("route"), "/home"));
```

---
