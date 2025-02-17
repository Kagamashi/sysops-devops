# OpenTelemetry Metric Instruments and Types

## **1. Introduction to OpenTelemetry Metrics**
OpenTelemetry Metrics provides a framework for collecting, processing, and exporting **telemetry data** to observability backends like **Prometheus, Azure Monitor, and Grafana**.

### **Key Concepts**
- **Metric Instruments** → Tools for recording measurements.
- **Synchronous vs. Asynchronous Metrics** → Determines how data is collected.
- **Aggregation Types** → Defines how metrics are processed (e.g., sum, histogram).

---

## **2. Metric Instruments in OpenTelemetry**
OpenTelemetry defines several metric types based on how values are recorded and updated.

### **1. Counter (Monotonic Increasing Value)**
- **Use Case:** Counting events (e.g., HTTP requests, database queries).
- **Monotonic** (only increases, cannot decrease).

---

### **2. UpDownCounter (Bidirectional Counter)**
- **Use Case:** Tracking values that can increase or decrease (e.g., active users, queue depth).
- **Allows both positive and negative increments.**

---

### **3. Histogram (Statistical Distribution of Values)**
- **Use Case:** Measuring request latency, response times, or memory usage.
- **Captures min, max, average, and percentiles.**

---

### **4. Gauge (Asynchronous Measurement)**
- **Use Case:** Monitoring system metrics (CPU usage, memory, temperature).
- **Values are set asynchronously.**

---

## **3. Synchronous vs. Asynchronous Instruments**
| Type | Instrument | Collection Method | Use Case |
|------|-----------|------------------|----------|
| **Synchronous** | Counter | **Manual `.add()` calls** | Tracking counts (HTTP requests) |
| **Synchronous** | UpDownCounter | **Manual `.add()` calls** | Fluctuating values (queue depth) |
| **Synchronous** | Histogram | **Manual `.record()` calls** | Response time tracking |
| **Asynchronous** | Gauge | **Callback function** | CPU, memory usage |

---

## **4. Best Practices for OpenTelemetry Metrics**
- **Use Counters for monotonic increments** (never decrease values).
- **Use UpDownCounters for fluctuating values** (e.g., active users, queue size).
- **Use Histograms for latency measurements** to analyze performance.
- **Use Gauges for system metrics** where polling is needed.
- **Optimize metric labels** → Too many unique label values can increase storage and query cost.

By implementing **the right metric instruments**, OpenTelemetry enables **efficient performance monitoring** and **real-time observability** across distributed systems.
