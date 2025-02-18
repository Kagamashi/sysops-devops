
## **Common Resource Attributes**
OpenTelemetry defines standard **resource attributes** to provide context about the telemetry data source.

### **Essential Resource Attributes**
| Attribute | Description | Example |
|-----------|-------------|---------|
| `service.name` | Name of the service emitting telemetry | `auth-service` |
| `service.namespace` | Namespace of the service | `ecommerce-platform` |
| `service.instance.id` | Unique instance ID of the service | `vm-1234` |
| `service.version` | Version of the service | `v1.2.3` |
| `host.name` | Hostname of the machine | `azure-vm-01` |
| `host.id` | Unique host identifier | `i-abcdef123456` |
| `cloud.provider` | Cloud provider name | `azure` |
| `cloud.region` | Cloud region where the service runs | `eastus` |
| `deployment.environment` | Application environment | `production` |

---

## **Standard Naming Conventions for Attributes**
To maintain consistency across observability systems, OpenTelemetry follows **semantic conventions** for naming attributes.

### **Best Practices for Attribute Naming**
- Use **dot-separated names** (`service.name`, `cloud.region`).
- Follow **lowercase with underscores** for custom attributes (`custom.metric_name`).
- Avoid **abbreviations** unless widely understood (`http.method`, not `http.m`).
- Keep attribute values **consistent across services**.

### **Example: Standard Attributes in an API Request Trace**
```json
{
  "traceId": "abcd1234",
  "attributes": {
    "service.name": "checkout-api",
    "http.method": "POST",
    "http.status_code": 200,
    "deployment.environment": "staging"
  }
}
```

---
