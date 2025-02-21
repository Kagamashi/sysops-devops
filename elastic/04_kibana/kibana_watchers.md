
## **Using Kibana Watchers for Alerts**
Kibana Watchers allow **automated monitoring** and **alerts** for specific conditions.

### **Basic Watcher Example (Trigger Alert on High Error Count)**
```json
PUT _watcher/watch/error_alert
{
  "trigger": {
    "schedule": { "interval": "5m" }
  },
  "input": {
    "search": {
      "request": {
        "indices": ["logs-*"],
        "body": {
          "query": {
            "match": { "level": "error" }
          }
        }
      }
    }
  },
  "condition": {
    "compare": {
      "ctx.payload.hits.total.value": { "gte": 10 }
    }
  },
  "actions": {
    "log": {
      "logging": {
        "text": "High number of errors detected!"
      }
    }
  }
}
```
### **Explanation:**
- Runs every **5 minutes**.
- Searches `logs-*` for **error messages**.
- Triggers an **alert** if error count **≥ 10**.
- Logs a message when triggered.

---
