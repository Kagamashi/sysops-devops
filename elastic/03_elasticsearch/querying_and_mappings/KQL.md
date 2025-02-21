
## **Writing Queries in Kibana Query Language (KQL)**
KQL is optimized for Kibana searches and provides a simpler syntax compared to Query DSL.

### **Basic Search Query**
```kql
status: "error"
```
This searches for documents where the `status` field contains "error".

### **Using Logical Operators**
```kql
status: "error" AND user: "admin"
```
Returns results where `status` is "error" and `user` is "admin".

```kql
status: "error" OR status: "warning"
```
Matches documents where `status` is either "error" or "warning".

```kql
NOT status: "success"
```
Excludes documents where `status` is "success".

### **Wildcard Searches**
```kql
message: log*
```
Finds documents where the `message` field starts with "log" (e.g., "logfile", "logging").

```kql
url: "*.example.com"
```
Matches URLs that end with `.example.com`.

### **Range Queries**
```kql
@timestamp >= "now-7d" AND @timestamp <= "now"
```
Finds logs from the last 7 days.

```kql
bytes >= 1000 AND bytes <= 5000
```
Returns results where the `bytes` field is between 1000 and 5000.

### **Field Existence Checks**
```kql
_response_time: *
```
Finds documents where the `_response_time` field is present.

```kql
NOT error_message: *
```
Finds documents that do not contain the `error_message` field.

### **Grouping and Nesting Queries**
```kql
(status: "error" OR status: "warning") AND user: "admin"
```
Ensures proper precedence when combining queries.

### **Fuzzy Matching**
```kql
username: "john~1"
```
Finds slight variations of "john" (e.g., "johnn", "jonn").

### **Proximity Search**
```kql
"quick brown fox"~5
```
Finds documents where "quick", "brown", and "fox" appear within 5 words of each other.

---
