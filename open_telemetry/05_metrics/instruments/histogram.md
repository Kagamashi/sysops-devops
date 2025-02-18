
## **Histogram (Statistical Distribution of Values)**
- **Use Case:** Measuring request latency, response times, or memory usage.
- **Captures min, max, average, and percentiles.**

#### **Python Example**
```python
request_latency = meter.create_histogram("request_latency")
request_latency.record(120, {"route": "/home"})
```

### **Java Example**
```java
DoubleHistogram latencyHistogram = meter.histogramBuilder("request_latency").build();
latencyHistogram.record(150.5, Attributes.of(stringKey("route"), "/home"));
```

---
