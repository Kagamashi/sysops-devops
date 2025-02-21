# Kibana APM Service Setup

## **1. Introduction to APM in Kibana**
**APM (Application Performance Monitoring)** in Kibana allows tracking application performance, tracing requests, and identifying bottlenecks. It integrates with Elasticsearch and Kibana to provide **real-time insights** into application behavior.

### **Key Features:**
- Distributed tracing for microservices.
- Performance analysis (latency, errors, throughput).
- Custom transactions and spans tracking.
- Automatic instrumentation for various languages.

---

## **2. Configuring APM Language Agents**
Elastic APM supports multiple **language agents** for collecting traces and sending them to the APM server.

### **Steps to Set Up an APM Agent:**
1. **Install the APM Agent** in your application.
2. **Configure the agent** to connect to the APM Server.
3. **Enable tracing** for automatic or manual instrumentation.
4. **Verify data in Kibana APM UI**.

### **Example Configurations for Popular Languages**

#### **Java (Spring Boot, Micronaut, Quarkus, etc.)**
```sh
java -javaagent:/path/to/elastic-apm-agent.jar \
     -Delastic.apm.service_name=my-java-service \
     -Delastic.apm.server_urls=http://apm-server:8200 \
     -Delastic.apm.secret_token= \
     -Delastic.apm.environment=production \
     -jar myapp.jar
```

#### **Node.js (Express, NestJS, Fastify, etc.)**
```javascript
const apm = require('elastic-apm-node').start({
  serviceName: 'my-node-service',
  serverUrl: 'http://apm-server:8200',
  environment: 'production'
});
```

#### **Python (Django, Flask, FastAPI, etc.)**
```python
import elasticapm
elasticapm.instrument()
app = Flask(__name__)
app.config['ELASTIC_APM'] = {
    'SERVICE_NAME': 'my-python-service',
    'SERVER_URL': 'http://apm-server:8200',
    'ENVIRONMENT': 'production'
}
```

#### **.NET (ASP.NET Core, Console Apps, etc.)**
```csharp
var builder = WebApplication.CreateBuilder(args);
builder.Services.AddElasticApm();
```

---

## **3. Configuring APM Indices in Elasticsearch**
APM data is stored in **Elasticsearch indices**, following a structured naming convention.

### **Default APM Index Naming Convention:**
| Data Type | Index Pattern |
|-----------|--------------|
| Transactions | `apm-*` |
| Spans | `apm-span-*` |
| Errors | `apm-error-*` |
| Metrics | `apm-metric-*` |

#### **Customizing Index Settings**
Modify APM index retention and settings:
```json
PUT _cluster/settings
{
  "persistent": {
    "xpack.apm.data_retention": "30d"
  }
}
```

---

## **4. Sampling and Performance Tuning**
Sampling reduces the **volume of collected traces** while maintaining meaningful insights.

### **Types of Sampling:**
- **Head-based Sampling:** Limits trace collection at the start of a request.
- **Tail-based Sampling:** Collects all traces and filters them afterward (requires more resources).

#### **Adjusting APM Sampling Rate**
```json
PUT _ilm/policy/apm-rollover-policy
{
  "policy": {
    "phases": {
      "hot": {
        "actions": {
          "rollover": {
            "max_age": "7d",
            "max_size": "50gb"
          }
        }
      }
    }
  }
}
```

### **Performance Tuning Best Practices:**
- **Adjust sampling rates** to balance performance and trace detail.
- **Disable auto-instrumentation** for non-critical components.
- **Optimize index settings** for storage efficiency.
- **Enable data retention policies** to manage storage usage.

---

## **5. Verifying and Monitoring APM Data**
Once the APM agent is sending data, use **Kibana APM UI** to monitor:
1. **Latency & throughput** graphs.
2. **Service dependencies** and call traces.
3. **Error rate analysis**.
4. **Custom transaction metrics**.

### **Checking APM Server Logs for Debugging**
```sh
kubectl logs -f deployment/apm-server
```

For more details, check **[Elastic APM Documentation](https://www.elastic.co/guide/en/apm/get-started.html)**.
