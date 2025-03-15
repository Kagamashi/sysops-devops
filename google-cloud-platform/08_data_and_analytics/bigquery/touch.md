# BigQuery

## 1. Overview
Google BigQuery is a **serverless, highly scalable data warehouse** designed for fast SQL analytics. Optimizing queries, using partitioned/clustered tables, and implementing security best practices are key to efficient and secure data management.

---

## 2. Query Optimization
Optimizing queries improves performance and reduces costs by minimizing data scanned.

### **1. Best Practices for Query Optimization**
✅ **Use `SELECT` only for required columns** instead of `SELECT *`.  
✅ **Filter using partitioned or clustered columns** for efficient scanning.  
✅ **Use `WITH` common table expressions (CTEs)** to structure complex queries.  
✅ **Avoid cross joins and Cartesian products** unless necessary.  
✅ **Use approximate aggregation functions** (e.g., `APPROX_COUNT_DISTINCT`) for faster results.  

### **2. Example: Optimized Query Using Partition Filtering**
```sql
SELECT user_id, event_type, event_time
FROM my_dataset.events
WHERE event_date BETWEEN '2024-01-01' AND '2024-01-10';
```

### **3. Querying Data Without Scanning Unnecessary Columns**
```sql
SELECT name, age FROM my_dataset.users;
```

---

## 3. Partitioned and Clustered Tables
Partitioning and clustering improve query performance by reducing the amount of data scanned.

### **1. Partitioned Tables**
- **Divide tables based on a specific column (e.g., `DATE`, `TIMESTAMP`).**
- Improves performance and **reduces query costs**.

#### **Creating a Partitioned Table by Date**
```sql
CREATE TABLE my_dataset.partitioned_table
PARTITION BY DATE(timestamp_column)
AS SELECT * FROM my_dataset.source_table;
```

### **2. Clustered Tables**
- Organizes data based on specific column values.
- Works well with **high-cardinality columns (e.g., user_id, device_id).**

#### **Creating a Clustered Table**
```sql
CREATE TABLE my_dataset.clustered_table
CLUSTER BY user_id, event_type
AS SELECT * FROM my_dataset.source_table;
```

### **Best Practices for Partitioning & Clustering**
✅ **Use partitioning for time-series data** (e.g., logs, events).  
✅ **Cluster columns with high cardinality** to speed up queries.  
✅ **Combine partitioning and clustering** when working with large datasets.  

---

## 4. Security and Governance
BigQuery supports **fine-grained access control** with **column-level and row-level security** to protect sensitive data.

### **1. Column-Level Security (Using Policy Tags)**
- Restricts access to specific columns using **Data Catalog policy tags**.
- Ensures **only authorized users** can see sensitive data.

#### **Example: Assigning a Policy Tag to a Column**
```sql
ALTER TABLE my_dataset.users
ALTER COLUMN email SET POLICY TAG 'projects/my-project/locations/us/taxonomies/my-taxonomy/policyTags/email_mask';
```

### **2. Row-Level Security (Using Authorized Views & Row Access Policies)**
- Restricts access to **specific rows** based on user identity.
- Helps enforce **data privacy and compliance policies**.

#### **Example: Creating a Row-Level Access Policy**
```sql
CREATE ROW ACCESS POLICY region_policy
ON my_dataset.sales
GRANT TO ('user:analyst@example.com')
FILTER USING (region = 'US');
```

---

## 5. Final Checklist
✅ Optimize queries using **partition filters and SELECT column limitations**.  
✅ Use **partitioned tables for time-series data** and **clustered tables for high-cardinality columns**.  
✅ Enforce **column-level security** using **policy tags**.  
✅ Implement **row-level security** for granular access control.  
✅ Monitor **query performance and optimize resource usage** using `EXPLAIN`.  

📌 **More Resources:** [Google BigQuery Documentation](https://cloud.google.com/bigquery/docs/)

