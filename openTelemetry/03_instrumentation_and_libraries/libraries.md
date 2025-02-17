# OpenTelemetry Community and Official Libraries

## **1. Finding OpenTelemetry Instrumentation Libraries**
OpenTelemetry provides both **official** and **community-contributed** instrumentation libraries to integrate tracing, metrics, and logs with various frameworks and services.

### **Official Sources for OpenTelemetry Libraries**
- **OpenTelemetry Registry** ([opentelemetry.io](https://opentelemetry.io/registry/))
- **GitHub Repositories** ([github.com/open-telemetry](https://github.com/open-telemetry))
- **Package Managers**:
  - **Java**: [Maven Central](https://mvnrepository.com/artifact/io.opentelemetry)
  - **Python**: [PyPI](https://pypi.org/project/opentelemetry-api/)
  - **.NET**: [NuGet](https://www.nuget.org/packages/OpenTelemetry/)
  - **Node.js**: [NPM](https://www.npmjs.com/package/@opentelemetry/api)

---

## **2. Common Official OpenTelemetry Libraries**
| Language | Instrumentation Library |
|----------|-------------------------|
| **Java** | `opentelemetry-java-instrumentation` |
| **Python** | `opentelemetry-instrumentation` |
| **.NET** | `OpenTelemetry.Instrumentation.AspNetCore` |
| **Node.js** | `@opentelemetry/instrumentation-http` |

---

## **3. Community-Contributed Instrumentation**
The OpenTelemetry community actively develops new libraries for popular frameworks and services.

### **Where to Find Community Libraries**
- **GitHub OpenTelemetry Community Repos** ([github.com/open-telemetry/opentelemetry-community](https://github.com/open-telemetry/opentelemetry-community))
- **Discussions in OpenTelemetry Slack** ([opentelemetry.io/community/](https://opentelemetry.io/community/))
- **Third-party contributions on GitHub & GitLab**

### **Examples of Community Libraries**
| Library | Description |
|---------|-------------|
| `opentelemetry-instrumentation-fastapi` | Adds OpenTelemetry tracing for FastAPI (Python) |
| `opentelemetry-rabbitmq` | RabbitMQ message queue tracing support |
| `opentelemetry-kubernetes` | Kubernetes-specific telemetry support |

---

## **4. Common Pitfalls in Using OpenTelemetry Libraries**
### **1. Version Mismatch Issues**
- **Problem:** API and SDK versions may not be compatible.
- **Solution:** Always check the official documentation and use matching versions.
  ```sh
  pip show opentelemetry-sdk opentelemetry-api
  ```

### **2. Incomplete Auto-Instrumentation Support**
- **Problem:** Some libraries may lack built-in instrumentation.
- **Solution:** Use **manual instrumentation** to capture missing spans and metrics.
  ```python
  from opentelemetry import trace
  tracer = trace.get_tracer("custom-service")
  with tracer.start_as_current_span("custom-operation"):
      print("Custom span added")
  ```

### **3. Exporter Compatibility**
- **Problem:** Not all OpenTelemetry exporters support every backend (e.g., Azure Monitor, Prometheus, Jaeger).
- **Solution:** Ensure that the correct exporter is installed and configured.
  ```sh
  export OTEL_EXPORTER_OTLP_ENDPOINT=http://otel-collector:4317
  ```

---
