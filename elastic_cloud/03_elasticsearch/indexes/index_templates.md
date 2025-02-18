
## **Index Templates**
Index templates define default settings and mappings for newly created indexes.

### **Creating an Index Template**
```json
PUT _index_template/my_template
{
  "index_patterns": ["logs-*"],
  "template": {
    "settings": {
      "number_of_shards": 2,
      "number_of_replicas": 1
    },
    "mappings": {
      "properties": {
        "event": { "type": "keyword" },
        "timestamp": { "type": "date" }
      }
    }
  }
}
```
- **Applies to indexes matching** `logs-*`
- Ensures consistency in index settings

---
