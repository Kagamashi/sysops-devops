# OpenTelemetry Structured Logging Basics

## **1. Introduction to OpenTelemetry Logging**
OpenTelemetry provides a standardized way to collect, process, and export logs alongside **traces** and **metrics**. Structured logging helps maintain **correlation** between logs and distributed traces.

### **Why Use OpenTelemetry for Logs?**
- **Unified Observability** → Combine logs, traces, and metrics.
- **Standardized Logging API** → Works across multiple languages.
- **Correlation** → Attach trace IDs and span IDs to logs.
- **Backend Agnostic** → Export logs to **Azure Monitor, Loki, Elasticsearch, and others**.

---

## **2. OpenTelemetry Log API vs. Bridging Existing Log Frameworks**

### **Option 1: Using OpenTelemetry Log API (Native Logging)**
OpenTelemetry provides its own **Log API** to generate structured logs with contextual metadata.

#### **Python Example (OTel Logging API)**
```python
from opentelemetry import logs
from opentelemetry.sdk.logs import LoggerProvider
from opentelemetry.sdk.logs.export import ConsoleLogExporter, SimpleLogRecordProcessor

logs.set_logger_provider(LoggerProvider())
logger = logs.get_logger("example-app")
logger.add_log_record_processor(SimpleLogRecordProcessor(ConsoleLogExporter()))

logger.info("User login successful", {"user_id": "12345"})
```

#### **Java Example (OTel Log API)**
```java
Logger logger = GlobalOpenTelemetry.getLogger("example-app");
logger.logRecordBuilder()
    .setSeverity(Severity.INFO)
    .setBody("User login successful")
    .setAttribute("user_id", "12345")
    .emit();
```

---

### **Option 2: Bridging Existing Logging Frameworks**
Instead of switching to the OTel Log API, many applications prefer to **bridge** OpenTelemetry with existing logging frameworks like **Logback, Log4j, and Winston**.

#### **Java (Logback + OpenTelemetry)**
```xml
<configuration>
    <appender name="OTEL" class="io.opentelemetry.contrib.logback.OpenTelemetryAppender">
        <encoder>
            <pattern>%d{yyyy-MM-dd HH:mm:ss} [%level] %msg trace_id=%X{trace_id} span_id=%X{span_id}%n</pattern>
        </encoder>
    </appender>
    <root level="info">
        <appender-ref ref="OTEL"/>
    </root>
</configuration>
```

#### **Node.js (Winston + OpenTelemetry)**
```javascript
const winston = require("winston");
const { trace } = require("@opentelemetry/api");

const logger = winston.createLogger({
    transports: [new winston.transports.Console()],
    format: winston.format.combine(
        winston.format.timestamp(),
        winston.format.printf(({ timestamp, level, message }) => {
            const span = trace.getSpan(trace.activeSpanContext());
            const traceId = span ? span.spanContext().traceId : "-";
            return `${timestamp} [${level}] ${message} trace_id=${traceId}`;
        })
    )
});

logger.info("Processing request");
```

---

## **3. Attaching Trace IDs and Correlation Fields**
One of the key benefits of **OpenTelemetry logging** is the ability to **correlate logs with traces**.

### **Best Practices for Attaching Trace Context to Logs**
| Correlation Field | Description |
|------------------|-------------|
| `trace_id` | Unique identifier for the entire trace. |
| `span_id` | Identifies the span within the trace. |
| `service.name` | Identifies the service emitting logs. |

#### **Example: Attaching Trace IDs in Python (Manual Context Injection)**
```python
from opentelemetry import trace
tracer = trace.get_tracer("example-app")

with tracer.start_as_current_span("process-request") as span:
    trace_id = trace.get_current_span().get_span_context().trace_id
    logger.info("Processing request", {"trace_id": trace_id})
```

#### **Example: Automatically Injecting Trace IDs in Java (MDC for Logback)**
```java
import org.slf4j.MDC;
import io.opentelemetry.api.trace.Span;

Span span = Span.current();
MDC.put("trace_id", span.getSpanContext().getTraceId());
logger.info("Processing request");
MDC.clear();
```

---

## **4. Exporting Logs to Observability Platforms**
OpenTelemetry allows logs to be exported to various backends **via OpenTelemetry Collector**.

### **Example: Exporting Logs via OpenTelemetry Collector (YAML Configuration)**
```yaml
receivers:
  filelog:
    include: ["/var/log/app.log"]
exporters:
  otlp:
    endpoint: "http://otel-collector:4317"
service:
  pipelines:
    logs:
      receivers: [filelog]
      exporters: [otlp]
```

---

## **5. Best Practices for OpenTelemetry Structured Logging**
- **Use a consistent logging format** (JSON or structured logs preferred).
- **Ensure trace and span IDs are included** in logs for correlation.
- **Choose the right approach** (OTel Log API vs. existing log framework integration).
- **Optimize log levels** (INFO, ERROR, DEBUG) to reduce noise.
- **Export logs via OpenTelemetry Collector** for centralized observability.
- **Enrich logs with resource attributes** to improve queryability in monitoring backends.

By implementing **structured logging with OpenTelemetry**, teams can **enhance observability**, improve debugging efficiency, and maintain **seamless correlation between logs, traces, and metrics**.
