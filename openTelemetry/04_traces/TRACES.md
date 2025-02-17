# OpenTelemetry Tracer Basics

## **1. What is a Tracer?**
A **tracer** is a core component in OpenTelemetry responsible for creating and managing **spans**, which represent units of work in a distributed system. Tracers are used to capture **distributed traces** across microservices.

### **Key Concepts:**
- **Tracer** → Used to create spans and track execution flow.
- **Span** → A single unit of work (e.g., an HTTP request, DB query).
- **Child Span** → A nested span within a parent span.
- **Attributes** → Key-value pairs that provide context to spans.
- **Events** → Timed annotations within a span.
- **Status** → Indicates success or failure of a span.

---

## **2. Creating and Managing Tracers**
### **Creating a Tracer in Different Languages**
#### **Java (Spring Boot)**
```java
import io.opentelemetry.api.trace.Span;
import io.opentelemetry.api.trace.Tracer;

Tracer tracer = GlobalOpenTelemetry.getTracer("my-app");
```

#### **Python (Flask)**
```python
from opentelemetry import trace
tracer = trace.get_tracer("my-app")
```

#### **Node.js (Express.js)**
```javascript
const { trace } = require("@opentelemetry/api");
const tracer = trace.getTracer("my-app");
```

---

## **3. Creating and Managing Spans**
### **Creating a Span**
#### **Java**
```java
Span span = tracer.spanBuilder("processRequest").startSpan();
try {
    // Business logic
} finally {
    span.end();
}
```

#### **Python**
```python
with tracer.start_as_current_span("process_request") as span:
    print("Processing request...")
```

#### **Node.js**
```javascript
const span = tracer.startSpan("processRequest");
try {
    console.log("Processing request...");
} finally {
    span.end();
}
```

---

## **4. Creating Child Spans**
Child spans allow tracking of nested operations within a parent span.

#### **Python**
```python
with tracer.start_as_current_span("parent") as parent:
    with tracer.start_as_current_span("child", parent=parent):
        print("Executing child operation")
```

#### **Java**
```java
Span parentSpan = tracer.spanBuilder("parent").startSpan();
Span childSpan = tracer.spanBuilder("child").setParent(Context.current().with(parentSpan)).startSpan();
```

---

## **5. Span Attributes, Events, and Status**
### **Adding Attributes to Spans**
Attributes provide additional context to traces.
#### **Python**
```python
with tracer.start_as_current_span("db_query") as span:
    span.set_attribute("db.system", "mysql")
    span.set_attribute("db.statement", "SELECT * FROM users")
```

#### **Java**
```java
span.setAttribute("http.method", "GET");
span.setAttribute("http.url", "https://example.com");
```

### **Adding Events to Spans**
Events capture significant moments in a span’s lifecycle.
#### **Node.js**
```javascript
span.addEvent("Fetching user data");
```

#### **Python**
```python
span.add_event("Fetching user data")
```

### **Setting Span Status**
Marks spans as success or failure.
#### **Python**
```python
span.set_status(trace.StatusCode.ERROR, "Database connection failed")
```

#### **Java**
```java
span.setStatus(StatusCode.ERROR, "Timeout occurred");
```

---

## **6. Best Practices for Tracing**
- **Use meaningful span names** (e.g., `http_request`, `db_query`).
- **Set relevant attributes** to enrich traces with metadata.
- **Use child spans** to track sub-operations within a request.
- **Capture events** to mark key milestones in execution.
- **Ensure spans have a clear start and end** to avoid memory leaks.
- **Use baggage for context propagation** across microservices.
