# SQL Databases

## 1. Overview
Google Cloud SQL is a **fully managed relational database service** that supports **MySQL, PostgreSQL, and SQL Server**. It provides built-in **high availability, automatic backups, and read replicas** for improved performance and reliability.

---

## 2. Cloud SQL Supported Databases
Cloud SQL supports multiple database engines, each with its own capabilities.

| **Database** | **Use Case** |
|-------------|-------------|
| **MySQL** | Web applications, transactional databases |
| **PostgreSQL** | Advanced analytics, extensibility, complex queries |
| **SQL Server** | Enterprise applications, Microsoft ecosystem integration |

### **Creating a Cloud SQL Instance**
```sh
gcloud sql instances create my-instance \
  --database-version=POSTGRES_14 \
  --tier=db-f1-micro \
  --region=us-central1
```

### **Connecting to Cloud SQL**
```sh
gcloud sql connect my-instance --user=postgres
```

---

## 3. High Availability (HA)
Cloud SQL provides **regional high availability** by replicating data across **multiple zones**.

### **Key Features**
- **Automatic failover** to a standby instance in case of failure.
- **Replication across zones** for improved resilience.
- **External IP or Private IP connectivity**.

### **Enabling HA for a Cloud SQL Instance**
```sh
gcloud sql instances create my-instance \
  --database-version=MYSQL_8_0 \
  --tier=db-custom-2-3840 \
  --region=us-central1 \
  --availability-type=REGIONAL
```

---

## 4. Read Replicas
Read replicas improve **read performance** and allow **horizontal scaling** of database workloads.

### **Benefits of Read Replicas**
- Offload read queries from the primary database.
- Distribute workloads across multiple replicas.
- Improve application scalability.

### **Creating a Read Replica**
```sh
gcloud sql instances create my-replica \
  --master-instance-name=my-instance \
  --region=us-central1
```

---

## 5. Backups & Point-in-Time Recovery (PITR)
Cloud SQL supports **automatic and on-demand backups** to prevent data loss.

### **1. Enabling Automated Backups**
```sh
gcloud sql instances patch my-instance \
  --backup-start-time=02:00
```

### **2. Creating an On-Demand Backup**
```sh
gcloud sql backups create --instance=my-instance
```

### **3. Restoring a Backup**
```sh
gcloud sql backups restore my-backup-id --instance=my-instance
```

---

## 6. Final Checklist
✅ Choose the **right database engine** based on workload needs.
✅ Enable **High Availability (HA)** for production-critical applications.
✅ Use **Read Replicas** to scale read-heavy workloads.
✅ Configure **automatic backups and PITR** to ensure data safety.
✅ Secure access using **IAM roles and private IP connections**.

📌 **More Resources:** [Google Cloud SQL Documentation](https://cloud.google.com/sql/docs/)
