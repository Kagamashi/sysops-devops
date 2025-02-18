# OpenTelemetry SDK vs. API

## **Understanding the Difference: API vs. SDK**
OpenTelemetry consists of two main components: the **API** and the **SDK**. Each serves a different role in the observability pipeline.

---

## **When to Use API vs. SDK**
### **Use OpenTelemetry API When:**
- Writing a **library** that should support observability without forcing a backend choice.
- You want to ensure compatibility with different telemetry providers.
- You don’t need to **process or export telemetry data** within your application.

### **Use OpenTelemetry SDK When:**
- Implementing a **service** that collects and exports telemetry data.
- You need to **configure exporters, processors, and samplers**.
- Your application **sends data to external monitoring tools** (e.g., Azure Monitor, Prometheus, Jaeger).

---

## **Best Practices**
- **Instrument using the API first** to maintain vendor neutrality.
- **Load the SDK dynamically** to allow flexibility in configuration.
- **Use environment variables** to configure the SDK (e.g., `OTEL_EXPORTER_OTLP_ENDPOINT`).
- **Leverage batching processors** in the SDK to optimize performance.
- **Combine with OpenTelemetry Collector** to centralize telemetry data management.

By separating instrumentation (API) from data processing (SDK), OpenTelemetry ensures **scalability, flexibility, and easy integration** into various observability platforms.

