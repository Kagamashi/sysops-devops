## PostgreSQL Security

### **Enforcing SSL/TLS Encryption**
Securing connections with SSL/TLS ensures encrypted data transmission.

#### **Check if SSL is enabled**
```sql
SHOW ssl;
```

#### **Enable SSL in postgresql.conf**
```ini
ssl = on
ssl_cert_file = '/etc/postgresql/server.crt'
ssl_key_file = '/etc/postgresql/server.key'
```

### **2. Configuring `pg_hba.conf` for Access Control**
The `pg_hba.conf` file controls client authentication.
```sh
sudo nano /etc/postgresql/14/main/pg_hba.conf
```

#### **Example Access Control Rules**
```ini
# Allow local connections
local   all             all                                     peer

# Allow password-based authentication from a specific subnet
host    all             all             192.168.1.0/24         md5

# Enforce SSL for remote connections
hostssl all             all             0.0.0.0/0              scram-sha-256
```

Restart PostgreSQL to apply changes:
```sh
sudo systemctl restart postgresql
```

---

## User Authentication and Password Management
### **1. Setting Up Password Authentication**
PostgreSQL supports multiple authentication methods:
- **MD5 Hashing** (deprecated but widely used)
- **SCRAM-SHA-256** (recommended for secure authentication)

#### **Set User Password with MD5**
```sql
ALTER USER myuser WITH ENCRYPTED PASSWORD 'mypassword';
```

#### **Set User Password with SCRAM-SHA-256**
```sql
ALTER ROLE myuser WITH PASSWORD 'securepassword' USING 'SCRAM-SHA-256';
```

### **2. Managing Database Roles Securely**
#### **Creating Users with Limited Privileges**
```sql
CREATE ROLE readonly_user WITH LOGIN PASSWORD 'readonlypass';
GRANT CONNECT ON DATABASE mydb TO readonly_user;
GRANT USAGE ON SCHEMA public TO readonly_user;
GRANT SELECT ON ALL TABLES IN SCHEMA public TO readonly_user;
```

#### **Revoking Privileges**
```sql
REVOKE INSERT, UPDATE, DELETE ON users FROM readonly_user;
```

---

## Best Security Practices
### **1. Enabling Audit Logging**
Enable logging to track connections and executed queries.

#### **Configure postgresql.conf for Logging**
```ini
log_connections = on
log_disconnections = on
log_statement = 'all'
log_min_duration_statement = 500
```

#### **View Connection Logs**
```sql
SELECT * FROM pg_stat_activity;
```

### **2. Preventing SQL Injection**
#### **Use Parameterized Queries** (Example in PL/pgSQL)
```sql
PREPARE safe_query (TEXT) AS SELECT * FROM users WHERE email = $1;
EXECUTE safe_query('user@example.com');
```

---
