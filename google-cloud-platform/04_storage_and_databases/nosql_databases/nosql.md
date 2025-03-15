# NoSQL and Distributed Databases

## 1. Overview
Google Cloud provides a variety of **NoSQL and distributed database services** designed for different workloads, including **Firestore, Bigtable, and Memorystore (Redis)**. These databases are optimized for scalability, real-time applications, and high-throughput workloads.

---

## 2. Firestore (Native vs Datastore Mode)
Firestore is a **serverless NoSQL document database** designed for mobile, web, and server applications. It supports two operational modes:

### **1. Native Mode (Recommended for New Apps)**
- **Strongly consistent** reads and writes.
- **Automatic scaling** with global multi-region support.
- **Real-time syncing** for event-driven applications.

### **2. Datastore Mode (Legacy Compatibility)**
- Optimized for **high-read, high-write workloads**.
- **Eventual consistency** for faster performance.
- Backward-compatible with **Google Datastore**.

### **Creating a Firestore Database**
```sh
gcloud firestore databases create --location=us-central1
```

### **Writing Data to Firestore**
```python
from google.cloud import firestore

db = firestore.Client()
doc_ref = db.collection("users").document("user1")
doc_ref.set({"name": "John Doe", "age": 30})
```

---

## 3. Bigtable
Bigtable is a **high-throughput, low-latency NoSQL database** designed for large-scale applications.

### **Use Cases**
- **Time-series data** (IoT, monitoring logs).
- **Real-time analytics** for large datasets.
- **Machine learning applications** (feature storage).

### **Key Features**
- **Petabyte-scale storage** with automatic sharding.
- **HBase API compatibility** for existing workloads.
- **Replication across multiple clusters**.

### **Creating a Bigtable Instance**
```sh
gcloud bigtable instances create my-bigtable-instance \
  --cluster=my-cluster --cluster-zone=us-central1-b \
  --display-name="My Bigtable"
```

---

## 4. Memorystore (Redis)
Memorystore is a **fully managed Redis service** that provides in-memory caching and session storage for high-performance applications.

### **Use Cases**
- **Caching frequently accessed data**.
- **Session management** for web applications.
- **Real-time analytics and leaderboard tracking**.

### **Creating a Redis Instance**
```sh
gcloud redis instances create my-redis \
  --size=5 --region=us-central1
```

### **Connecting to Memorystore Redis**
```sh
gcloud redis instances describe my-redis
```

---

## 5. Data Modeling and Best Practices
### **Firestore Best Practices**
✅ **Use hierarchical structures** to group related data.
✅ **Index queries properly** to avoid performance issues.
✅ **Use batched writes** for efficiency.

### **Bigtable Best Practices**
✅ **Design efficient row keys** for fast lookups.
✅ **Use column families** to group related data logically.
✅ **Avoid excessive small writes** to optimize performance.

### **Memorystore Best Practices**
✅ **Use TTL (Time to Live) policies** to evict stale cache entries.
✅ **Scale Redis instances based on demand.**
✅ **Monitor usage with Cloud Monitoring.**

📌 **More Resources:** [Google Cloud NoSQL Documentation](https://cloud.google.com/databases/docs/)

