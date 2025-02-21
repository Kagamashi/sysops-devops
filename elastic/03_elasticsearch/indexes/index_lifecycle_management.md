
# ILM
## **Index Lifecycle Management (ILM)**
ILM automates index transitions across **hot, warm, cold, and frozen** data tiers to optimize storage.

### **ILM Phases and Data Tiers**
| Phase | Data Tier | Purpose |
|-------|----------|---------|
| **Hot** | Fast SSD | High-speed indexing & search |
| **Warm** | Slower SSD | Retain older but still searchable data |
| **Cold** | Low-cost storage | Archive infrequent-access data |
| **Frozen** | Object storage | Cost-efficient long-term retention |

### **Creating an ILM Policy**
```json
PUT _ilm/policy/logs_policy
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
      },
      "warm": {
        "actions": {
          "allocate": {
            "require": { "data": "warm" }
          },
          "forcemerge": { "max_num_segments": 1 }
        }
      },
      "cold": {
        "actions": {
          "allocate": {
            "require": { "data": "cold" }
          }
        }
      }
    }
  }
}
```
- **Hot Phase** → Rolls over when index reaches **7 days or 50GB**.
- **Warm Phase** → Moves index to warm nodes and optimizes storage.
- **Cold Phase** → Moves index to cold nodes for long-term storage.

### **Applying ILM Policy to an Index**
```json
PUT logs-000001
{
  "settings": {
    "index.lifecycle.name": "logs_policy",
    "index.lifecycle.rollover_alias": "logs"
  }
}
```

---
