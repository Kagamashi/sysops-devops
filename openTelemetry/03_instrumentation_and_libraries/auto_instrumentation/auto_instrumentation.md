# OpenTelemetry Auto-Instrumentation Basics

## **1. What is Auto-Instrumentation?**
Auto-instrumentation allows applications to collect telemetry data **without modifying source code**. OpenTelemetry provides **prebuilt agents** for various languages that hook into common frameworks and libraries.

### **Key Benefits:**
- **Zero code changes** required for instrumentation.
- **Quick setup** for tracing, metrics, and logging.
- **Standardized observability** across microservices.
- **Compatible with multiple backends** (Azure Monitor, Prometheus, Jaeger, Zipkin).

---

## **2. Available Auto-Instrumentation Agents**
OpenTelemetry provides auto-instrumentation for several languages:

| Language | Auto-Instrumentation Method |
|----------|-----------------------------|
| **Java** | Java Agent (`opentelemetry-javaagent.jar`) |
| **Python** | `opentelemetry-instrument` CLI tool |
| **.NET** | OpenTelemetry .NET Instrumentation (`OTEL_DOTNET_AUTO`) |
| **Node.js** | `@opentelemetry/auto-instrumentations-node` package |

---

## **3. Configuring Auto-Instrumentation**
Auto-instrumentation agents can be configured using **environment variables** or **command-line flags**.

### **Java Auto-Instrumentation**
#### **Installation & Configuration**
```sh
wget https://github.com/open-telemetry/opentelemetry-java-instrumentation/releases/latest/download/opentelemetry-javaagent.jar
```
#### **Run a Java Application with Auto-Instrumentation**
```sh
java -javaagent:opentelemetry-javaagent.jar \
     -Dotel.service.name=my-java-app \
     -Dotel.exporter.otlp.endpoint=http://otel-collector:4317 \
     -jar myapp.jar
```

---

### **Python Auto-Instrumentation**
#### **Installation**
```sh
pip install opentelemetry-instrumentation
```
#### **Run a Python Application with Auto-Instrumentation**
```sh
opentelemetry-instrument python myapp.py
```
#### **Configure via Environment Variables**
```sh
export OTEL_SERVICE_NAME=my-python-app
export OTEL_EXPORTER_OTLP_ENDPOINT=http://otel-collector:4317
```

---

### **.NET Auto-Instrumentation**
#### **Installation**
```sh
dotnet add package OpenTelemetry.AutoInstrumentation
```
#### **Run a .NET Application with Auto-Instrumentation**
```sh
set OTEL_DOTNET_AUTO_ENABLED=true
set OTEL_SERVICE_NAME=my-dotnet-app
set OTEL_EXPORTER_OTLP_ENDPOINT=http://otel-collector:4317
```

---

### **Node.js Auto-Instrumentation**
#### **Installation**
```sh
npm install --save @opentelemetry/auto-instrumentations-node
```
#### **Run a Node.js Application with Auto-Instrumentation**
```javascript
const { registerInstrumentations } = require('@opentelemetry/instrumentation');
const { NodeTracerProvider } = require('@opentelemetry/sdk-trace-node');
const { OTLPTraceExporter } = require('@opentelemetry/exporter-trace-otlp-http');

registerInstrumentations({
  tracerProvider: new NodeTracerProvider(),
});
```
#### **Configure via Environment Variables**
```sh
export OTEL_SERVICE_NAME=my-node-app
export OTEL_EXPORTER_OTLP_ENDPOINT=http://otel-collector:4317
```

---

## **4. Best Practices for Auto-Instrumentation**
- **Use environment variables** for dynamic configuration across environments.
- **Verify library compatibility** (some older versions may not support auto-instrumentation).
- **Use OpenTelemetry Collector** to process and export data efficiently.
- **Monitor performance impact** (instrumentation adds minimal overhead but should be tested).
- **Combine auto-instrumentation with manual spans** for deeper insights.

By leveraging OpenTelemetry’s **auto-instrumentation capabilities**, teams can quickly instrument their applications **without modifying code**, ensuring seamless observability across distributed systems.

