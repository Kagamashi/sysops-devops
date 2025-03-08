# PostgreSQL Monitoring

## pg_stat_activity and Locking
### **1. Checking Running Queries**
`pg_stat_activity` provides details about active queries and connections.
```sql
SELECT * FROM pg_stat_activity;
```

### **2. Detecting Long-Running Transactions**
```sql
SELECT pid, age(clock_timestamp(), query_start) AS duration, query
FROM pg_stat_activity
WHERE state != 'idle'
ORDER BY duration DESC;
```

### **3. Identifying and Resolving Deadlocks**
Deadlocks occur when transactions block each other. To detect them:
```sql
SELECT pid, usename, waiting, query FROM pg_stat_activity WHERE waiting;
```
To terminate a blocking query:
```sql
SELECT pg_terminate_backend(12345); -- Replace 12345 with the PID
```

---

## Monitoring Tools for PostgreSQL
### **1. Using pgAdmin for Database Monitoring**
pgAdmin provides a GUI for managing and monitoring PostgreSQL.
- View database statistics
- Monitor active queries
- Analyze query performance with EXPLAIN

### **2. Installing `pg_stat_statements` for Query Performance Analysis**
Enable the `pg_stat_statements` extension to track slow queries.
```sql
CREATE EXTENSION pg_stat_statements;
SELECT * FROM pg_stat_statements ORDER BY total_exec_time DESC LIMIT 10;
```

### **3. Using Prometheus and Grafana for Real-Time Monitoring**
- **Prometheus** collects database metrics.
- **Grafana** visualizes PostgreSQL performance.
```sh
# Install PostgreSQL Exporter for Prometheus
sudo apt install prometheus-postgres-exporter
```

---

## Troubleshooting Common Errors
### **1. Fixing `FATAL: role does not exist`**
Occurs when trying to connect with a non-existent role.
```sql
CREATE ROLE myuser WITH LOGIN PASSWORD 'mypassword';
```

### **2. Fixing `ERROR: relation does not exist`**
Occurs when querying a missing table.
```sql
SELECT * FROM information_schema.tables WHERE table_name = 'users';
```
To fix:
- Check the **schema** using `SET search_path TO public;`
- Verify table existence with `\dt`

### **3. Fixing Corrupt Indexes and Database Inconsistencies**
Rebuilding an index:
```sql
REINDEX TABLE users;
```
Running a database consistency check:
```sh
pg_dump mydb > /dev/null
```
If errors occur, a full vacuum might be needed:
```sql
VACUUM FULL;
```

---

