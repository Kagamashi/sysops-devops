# Spanner

## 1. Overview
Google Cloud Spanner is a **fully managed, horizontally scalable, globally distributed relational database**. It provides **strong consistency, automatic scaling, and high availability**, making it ideal for mission-critical applications that require both high availability and relational integrity.

---

## 2. Horizontal Scaling and Global Consistency

### **1. Horizontal Scaling**
- Spanner **scales horizontally** across multiple nodes while maintaining strong consistency.
- It uses **automatic sharding** to distribute data across multiple servers.
- Unlike traditional relational databases, **Spanner does not require manual partitioning**.

### **2. Global Consistency**
- Spanner ensures **strong consistency with TrueTime synchronization**, eliminating the trade-off between scalability and ACID compliance.
- Provides **cross-region replication** with synchronous writes, ensuring low-latency reads globally.
- Supports **multi-region deployments** for high availability and disaster recovery.

### **Creating a Spanner Instance**
```sh
gcloud spanner instances create my-instance \
  --config=regional-us-central1 \
  --processing-units=500 \
  --description="My Spanner Instance"
```

### **Creating a Spanner Database**
```sh
gcloud spanner databases create my-database \
  --instance=my-instance
```

---

## 3. Schema Design in Spanner
Spanner supports **relational schemas**, but its scalability model requires careful schema design.

### **Key Considerations for Schema Design**
- Use **primary keys that distribute writes evenly** to avoid hotspots.
- **Denormalization** is often recommended for performance optimization.
- Use **interleaved tables** for related entities to minimize cross-region lookups.

### **Example: Creating a Table with Interleaving**
```sql
CREATE TABLE Users (
  UserID STRING(36) NOT NULL,
  Name STRING(100),
  Email STRING(100),
) PRIMARY KEY (UserID);

CREATE TABLE Orders (
  OrderID STRING(36) NOT NULL,
  UserID STRING(36) NOT NULL,
  Amount FLOAT64,
  OrderDate TIMESTAMP,
) PRIMARY KEY (OrderID),
  INTERLEAVE IN PARENT Users ON DELETE CASCADE;
```

---

## 4. Performance Tuning
Optimizing Spanner involves balancing **query performance, storage efficiency, and scaling costs**.

### **1. Query Optimization**
- Use **Spanner Query Execution Plans** to analyze query performance.
- Optimize **joins and filter conditions** to reduce computation time.
- Use **secondary indexes** where appropriate, but avoid excessive indexing.

### **2. Partitioning and Load Balancing**
- Use **UUIDs or hashed keys** for primary keys to avoid hot partitions.
- Leverage **multi-region configurations** for optimal data placement.
- Monitor **CPU and storage utilization** with Cloud Monitoring.

### **Checking Query Execution Plans**
```sql
EXPLAIN SELECT * FROM Users WHERE UserID='12345';
```

### **Creating a Secondary Index**
```sql
CREATE INDEX idx_UserEmail ON Users (Email);
```

---

## 5. Final Checklist
✅ Use **regional or multi-region configurations** based on availability needs.
✅ Design **schemas with interleaved tables** to improve query performance.
✅ Ensure **primary keys are well-distributed** to avoid hot partitions.
✅ Use **query execution plans** to optimize performance.
✅ Monitor and scale **processing units** as needed.

📌 **More Resources:** [Google Cloud Spanner Documentation](https://cloud.google.com/spanner/docs/)

