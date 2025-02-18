
## **Writing Queries in Elasticsearch DSL**
Elasticsearch queries are written in JSON format and use the `_search` API.

### **Basic Match Query (Full-Text Search)**
```json
GET my_index/_search
{
  "query": {
    "match": {
      "message": "error log"
    }
  }
}
```

### **Boolean Query (Combining Conditions)**
```json
GET my_index/_search
{
  "query": {
    "bool": {
      "must": [{ "match": { "status": "error" } }],
      "filter": [{ "term": { "user_id": "12345" } }]
    }
  }
}
```
- **`must`** → Matches required conditions.
- **`filter`** → Improves performance by filtering without scoring.

### **Aggregations (Grouping & Metrics)**
```json
GET my_index/_search
{
  "aggs": {
    "status_count": {
      "terms": { "field": "status.keyword" }
    }
  }
}
```

---
