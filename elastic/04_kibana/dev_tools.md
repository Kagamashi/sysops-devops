# Kibana Dev Tools and Console

## **1. Introduction to Kibana Dev Tools**
Kibana Dev Tools provides a **quick and interactive interface** for executing queries against Elasticsearch using the **Console**, allowing users to retrieve, modify, and manage data efficiently.

### **Key Features:**
- Run **Elasticsearch API queries** (GET, POST, PUT, DELETE).
- Quickly test and troubleshoot **index mappings, documents, and aggregations**.
- **Format JSON responses** automatically for readability.

---

## **2. Quick Queries Using Dev Tools (Console)**

### **Basic Queries**
#### **Retrieve Cluster Health**
```json
GET _cluster/health
```
Returns the cluster's health status (**green**, **yellow**, or **red**).

#### **Get All Indexes**
```json
GET _cat/indices?v
```
Lists all indexes with their status and storage details.

#### **Search for Documents**
```json
GET my_index/_search
{
  "query": {
    "match": {
      "message": "error"
    }
  }
}
```
Finds all documents in `my_index` where the `message` field contains "error".

#### **Insert a Document**
```json
POST my_index/_doc/
{
  "user": "admin",
  "action": "login",
  "timestamp": "2024-02-17T12:00:00"
}
```
Adds a new document to `my_index`.

#### **Update a Document**
```json
POST my_index/_update/1
{
  "doc": {
    "action": "logout"
  }
}
```
Updates the document with `_id=1`, modifying the `action` field.

#### **Delete a Document**
```json
DELETE my_index/_doc/1
```
Deletes the document with `_id=1`.

---

## **3. Short References for Advanced Queries in Kibana**

### **Aggregations (Summarizing Data)**
#### **Count Events per User**
```json
GET my_index/_search
{
  "aggs": {
    "users": {
      "terms": { "field": "user.keyword" }
    }
  }
}
```
Returns the count of events per user.

### **Date Histogram for Log Analysis**
```json
GET logs-*/_search
{
  "size": 0,
  "aggs": {
    "log_trend": {
      "date_histogram": {
        "field": "@timestamp",
        "calendar_interval": "1h"
      }
    }
  }
}
```
Groups log events by **hourly intervals**.

---

## **Best Practices for Kibana Dev Tools & Console**
- **Use `_cat/indices?v`** to quickly check index health.
- **Leverage aggregations** to summarize and analyze data efficiently.
- **Use the `_simulate` API** before creating Watchers to validate conditions.
- **Optimize searches** by limiting the number of results (`size` field).
- **Use field filtering** (`_source`) to retrieve only necessary data.

For more details, visit **[Kibana Dev Tools Documentation](https://www.elastic.co/guide/en/kibana/current/dev-tools.html)**.
