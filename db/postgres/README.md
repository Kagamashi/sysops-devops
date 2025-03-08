## PostgreSQL
A powerful, open-source, enterprise-grade relational database known for its extensibility, data integrity, and advanced SQL compliance.

- **Official Docs**: [https://www.postgresql.org/docs/](https://www.postgresql.org/docs/)
- **Wiki & HOWTOs**: [https://wiki.postgresql.org/](https://wiki.postgresql.org/)
- **Download**: [https://www.postgresql.org/download/](https://www.postgresql.org/download/)
- **Performance Tuning**: [https://www.postgresql.org/docs/current/performance-tips.html](https://www.postgresql.org/docs/current/performance-tips.html)

---

### Dictionary

- **ACID**: Stands for Atomicity, Consistency, Isolation, Durability — the cornerstone of reliable transactions.
- **MVCC** (*Multiversion Concurrency Control*): PostgreSQL’s system for handling concurrent reads and writes without blocking.
- **WAL** (*Write-Ahead Logging*): Mechanism ensuring durability by writing changes to a log before updating data files.
- **psql**: The command-line interface for interacting with PostgreSQL.
- **Schema**: A logical container for database objects (tables, views, functions, etc.).
- **Extension**: Add-on modules that extend PostgreSQL’s functionality (e.g., `pg_stat_statements`, `postgis`).
- **Vacuum**: Process to remove dead tuples and reclaim storage, improving performance.
- **Explain Analyze**: Command to visualize query execution plans and measure performance in real time.

---

### CRDs (Custom Resource Definitions)

> PostgreSQL itself does not have official CRDs.  
> However, some **Kubernetes operators** (e.g., [Zalando Postgres Operator](https://github.com/zalando/postgres-operator)) provide CRDs for managing PostgreSQL clusters in a Kubernetes environment.

---

### Other

- **Backup & Restore**:
  - Logical backups: `pg_dump` and `pg_restore`
  - PITR (Point-in-Time Recovery): Requires WAL archiving
- **Security**:
  - Use `pg_hba.conf` and `postgresql.conf` to enforce secure connections (SSL, scram-sha-256).
- **Performance Tuning**:
  - Key settings: `shared_buffers`, `work_mem`, `effective_cache_size`
  - Indexing: B-tree, GIN, BRIN for specialized queries

```sh
# Switch to PostgreSQL CLI as 'postgres' user
sudo -i -u postgres psql
```

---
