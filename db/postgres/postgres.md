# PostgreSQL

[PostgreSQL Official Documentation](https://www.postgresql.org/docs/)

## Overview and Architecture
### **What is PostgreSQL?**
PostgreSQL is an **open-source, enterprise-class relational database management system (RDBMS)** known for its **extensibility, stability, and SQL compliance**. It supports:
- **ACID transactions** ensuring data reliability.
- **Multiversion Concurrency Control (MVCC)** for high performance.
- **Advanced indexing techniques** like GIN and BRIN.
- **JSON support** for semi-structured data.

### **How PostgreSQL Stores Data**
PostgreSQL organizes and stores data using:
- **Heap Storage**: Tables are stored as heaps (unordered rows), with each row called a **tuple**.
- **Tuples and Visibility**: PostgreSQL uses MVCC to maintain multiple versions of rows, improving concurrency.
- **Write-Ahead Logging (WAL)**: Changes are first written to WAL logs before committing to storage, ensuring crash recovery and durability.

### **ACID Transactions and MVCC**
PostgreSQL enforces **ACID properties** for reliable transactions:
- **Atomicity**: Transactions execute completely or not at all.
- **Consistency**: Database remains in a valid state before and after transactions.
- **Isolation**: Multiple transactions occur independently.
- **Durability**: Committed transactions persist even after crashes.

MVCC allows transactions to work without blocking each other by **keeping multiple versions of data**, reducing contention and improving performance.

---

## Data Directory and Storage
### **1. Understanding PGDATA and WAL Logs**
- `PGDATA`: Main data directory where PostgreSQL stores databases.
- `pg_wal`: Write-Ahead Logging (WAL) directory for crash recovery.

### **2. Moving PostgreSQL Data Directory**
```sh
sudo systemctl stop postgresql
sudo mv /var/lib/postgresql /new/location/postgresql
sudo ln -s /new/location/postgresql /var/lib/postgresql
sudo systemctl start postgresql
```

---
