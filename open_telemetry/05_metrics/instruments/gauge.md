
## **Gauge (Asynchronous Measurement)**
- **Use Case:** Monitoring system metrics (CPU usage, memory, temperature).
- **Values are set asynchronously.**

### **Python Example**
```python
def get_cpu_usage():
    return psutil.cpu_percent()

meter.create_observable_gauge(
    "cpu_usage", get_cpu_usage, "CPU Usage Percentage"
)
```

#### **Node.js Example**
```javascript
meter.createObservableGauge("cpu_usage", async (observableResult) => {
    observableResult.observe(process.cpuUsage().user);
});
```

---
