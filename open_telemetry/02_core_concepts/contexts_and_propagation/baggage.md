
## **Baggage: Propagating Custom Metadata**
**Baggage** allows applications to attach metadata to a trace and propagate it across requests.

### **Common Use Cases**
- **User Identity:** Attach user ID to logs for debugging.
- **Region Awareness:** Track region-specific requests.
- **Feature Flags:** Pass feature toggle information between services.

### **Baggage Headers**
| Header | Description |
|--------|-------------|
| `baggage` | Contains key-value pairs of contextual metadata. |

#### **Example of a Baggage Header**
```
baggage: userId=12345,region=us-east-1,featureFlag=beta
```

#### **Setting Baggage in Python**
```python
from opentelemetry.baggage import set_baggage, get_baggage

set_baggage("user_id", "12345")
print(get_baggage("user_id"))  # Outputs: 12345
```

---
