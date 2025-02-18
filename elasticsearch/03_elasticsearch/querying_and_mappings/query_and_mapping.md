# Elasticsearch Querying and Mappings

## **Introduction to Querying in Elasticsearch**
Elasticsearch uses a powerful **Domain-Specific Language (DSL)** and **Kibana Query Language (KQL)** for querying structured and unstructured data.

### **Query Language Options**
- **Elasticsearch Query DSL** → JSON-based, supports full-text search, aggregations, and filtering.
- **KQL (Kibana Query Language)** → Simplified syntax for searching in Kibana.

---

## **Best Practices for Mappings**
Mappings define how data fields are stored and indexed.

### **Defining a Mapping for an Index**
```json
PUT my_index
{
  "mappings": {
    "properties": {
      "timestamp": { "type": "date" },
      "status": { "type": "keyword" },
      "message": { "type": "text" }
    }
  }
}
```

### **Best Practices:**
- Use **`keyword`** for exact matching fields.
- Use **`text`** for full-text search fields.
- Define **date fields properly** for time-based searches.
- Avoid dynamic mapping in production to prevent unintended schema changes.

---

## **Handling Schema Changes & Reindexing**
Schema changes require **reindexing**, as mappings cannot be modified once set.

### **Reindexing Data into a New Index**
```json
POST _reindex
{
  "source": { "index": "old_index" },
  "dest": { "index": "new_index" }
}
```

### **Best Practices for Schema Changes**
- Use **index templates** to enforce field mappings for new indices.
- Implement **aliases** to switch indices without downtime.
- Use **reindexing with transformations** for data modifications.

---

## **Conclusion**
- Use **Query DSL** for complex searches and analytics.
- Use **KQL** for simple filtering in Kibana.
- Define **proper mappings** to optimize storage and query performance.
- Plan for **schema changes with reindexing** to avoid downtime.

For more details, visit [Elasticsearch Query DSL Documentation](https://www.elastic.co/guide/en/elasticsearch/reference/current/query-dsl.html).
