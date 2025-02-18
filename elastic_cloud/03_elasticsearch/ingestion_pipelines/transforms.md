
## **Using Transforms for Aggregated Views**
Elasticsearch **Transforms** allow creating **aggregated views** of indexed data for analytics and reporting.

### **Key Features:**
- Convert raw documents into **summarized, structured indices**.
- Aggregate logs, transactions, and time-series data.
- Create **entity-centric** indexes for faster querying.

### **Example: Creating a Transform for Daily User Activity**
```json
PUT _transform/daily_user_activity
{
  "source": { "index": "user_logs" },
  "pivot": {
    "group_by": {
      "user_id": { "terms": { "field": "user_id" } },
      "date": { "date_histogram": { "field": "timestamp", "calendar_interval": "1d" } }
    },
    "aggregations": {
      "total_events": { "value_count": { "field": "event" } }
    }
  },
  "dest": { "index": "daily_user_summary" }
}
```
### **Explanation:**
- Groups logs by **user_id and daily timestamps**.
- Counts the **number of events per user per day**.
- Saves the transformed data in the `daily_user_summary` index.

### **Starting a Transform Job**
```sh
POST _transform/daily_user_activity/_start
```

### **Checking Transform Status**
```sh
GET _transform/daily_user_activity/_stats
```

---
