# OpenTelemetry Manual Instrumentation Examples

## **1. What is Manual Instrumentation?**
Manual instrumentation allows developers to explicitly add telemetry **(tracing, metrics, and logs)** within their code, offering more control over observability.

### **Key Benefits:**
- Provides **fine-grained control** over spans, metrics, and logs.
- Allows **custom telemetry data collection** beyond auto-instrumentation.
- Enables tracing **specific business logic** within applications.
- Supports **distributed tracing across microservices**.

---

## **2. Adding Manual Tracing in Different Languages**

### **Java (Spring Boot Example)**
#### **Dependencies**
```xml
<dependency>
    <groupId>io.opentelemetry</groupId>
    <artifactId>opentelemetry-api</artifactId>
    <version>1.15.0</version>
</dependency>
```

#### **Adding a Custom Span in Java**
```java
import io.opentelemetry.api.trace.Span;
import io.opentelemetry.api.trace.Tracer;

public class ExampleService {
    private static final Tracer tracer = GlobalOpenTelemetry.getTracer("example-service");
    
    public void processRequest() {
        Span span = tracer.spanBuilder("processRequest").startSpan();
        try {
            System.out.println("Processing request...");
        } finally {
            span.end();
        }
    }
}
```

---

### **Python (Flask Example)**
#### **Install Dependencies**
```sh
pip install opentelemetry-api opentelemetry-sdk
```

#### **Adding a Custom Span in Python**
```python
from opentelemetry import trace
from opentelemetry.sdk.trace import TracerProvider
from opentelemetry.sdk.trace.export import ConsoleSpanExporter, SimpleSpanProcessor

trace.set_tracer_provider(TracerProvider())
tracer = trace.get_tracer(__name__)
trace.get_tracer_provider().add_span_processor(SimpleSpanProcessor(ConsoleSpanExporter()))

def process_request():
    with tracer.start_as_current_span("process_request"):
        print("Processing request...")
```

---

### **.NET (ASP.NET Core Example)**
#### **Install Dependencies**
```sh
dotnet add package OpenTelemetry.Api
```

#### **Adding a Custom Span in .NET**
```csharp
using OpenTelemetry;
using OpenTelemetry.Trace;

var tracerProvider = Sdk.CreateTracerProviderBuilder()
    .AddSource("ExampleService")
    .Build();

var tracer = TracerProvider.Default.GetTracer("ExampleService");

using (var span = tracer.StartActiveSpan("process_request")) {
    Console.WriteLine("Processing request...");
}
```

---

### **Node.js (Express.js Example)**
#### **Install Dependencies**
```sh
npm install @opentelemetry/api @opentelemetry/sdk-trace-node
```

#### **Adding a Custom Span in Node.js**
```javascript
const { trace } = require("@opentelemetry/api");
const tracer = trace.getTracer("example-service");

function processRequest() {
    const span = tracer.startSpan("process_request");
    console.log("Processing request...");
    span.end();
}
```

---

## **3. Adding Manual Metrics in OpenTelemetry**
### **Python Example (Metrics Counter)**
```python
from opentelemetry import metrics
meter = metrics.get_meter("example-meter")
requests_counter = meter.create_counter("requests.count")
requests_counter.add(1, {"status": "success"})
```

### **Node.js Example (Histogram for Request Latency)**
```javascript
const { metrics } = require("@opentelemetry/api");
const meter = metrics.getMeter("example-meter");
const requestDuration = meter.createHistogram("request.duration");
requestDuration.record(100, {"route": "/home"});
```

---

## **4. Best Practices for Manual Instrumentation**
- **Use auto-instrumentation first**, then manually add spans for critical business logic.
- **Always close spans** to prevent memory leaks.
- **Attach metadata** (e.g., user ID, request ID) to spans and metrics.
- **Use baggage and context propagation** to track requests across services.
- **Test instrumentation locally** before deploying to production.
