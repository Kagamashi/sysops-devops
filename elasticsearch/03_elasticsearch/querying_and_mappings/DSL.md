
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

### **Term Query (Exact Match Search)**
```json
GET my_index/_search
{
  "query": {
    "term": {
      "status.keyword": "error"
    }
  }
}
```

### **Wildcard Query**
```json
GET my_index/_search
{
  "query": {
    "wildcard": {
      "message": "log*"
    }
  }
}
```

### **Range Query**
```json
GET my_index/_search
{
  "query": {
    "range": {
      "timestamp": {
        "gte": "now-7d/d",
        "lte": "now/d"
      }
    }
  }
}
```

### **Exists Query (Checking Field Presence)**
```json
GET my_index/_search
{
  "query": {
    "exists": {
      "field": "response_time"
    }
  }
}
```

### **Fuzzy Matching**
```json
GET my_index/_search
{
  "query": {
    "fuzzy": {
      "username": {
        "value": "john",
        "fuzziness": "AUTO"
      }
    }
  }
}
```

### **Proximity Search (Phrase Matching Within Distance)**
```json
GET my_index/_search
{
  "query": {
    "match_phrase": {
      "message": {
        "query": "quick brown fox",
        "slop": 5
      }
    }
  }
}
```

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
