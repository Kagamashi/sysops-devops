# PostgreSQL Backup

## Backup and Restore with pg_dump
### **1. Using `pg_dump` for Logical Backups**
`pg_dump` is used for logical backups of PostgreSQL databases.

#### **Backup a Single Database**
```sh
pg_dump -U myuser -W -F c -f mydb_backup.dump mydb
```
- `-U myuser`: Specifies the user.
- `-W`: Prompts for a password.
- `-F c`: Custom format (use `-F t` for tar, `-F p` for plain text).

#### **Restore a Database from Backup**
```sh
pg_restore -U myuser -d mydb -F c mydb_backup.dump
```

#### **Backup All Databases**
```sh
pg_dumpall -U myuser -W -f all_databases_backup.sql
```

### **2. Automating Backups with Cron**
Schedule daily backups using `cron`.
```sh
crontab -e
```
Add the following line to schedule a daily backup at 2 AM:
```sh
0 2 * * * pg_dump -U myuser -W -F c -f /backups/mydb_$(date +\%F).dump mydb
```

---

## Point-in-Time Recovery and WAL Archiving
### **1. Enabling WAL Archiving**
Write-Ahead Logging (WAL) ensures data durability and is required for **Point-in-Time Recovery (PITR)**.

#### **Modify `postgresql.conf`**
```ini
archive_mode = on
archive_command = 'cp %p /var/lib/postgresql/wal_archive/%f'
```

### **2. Performing Point-in-Time Recovery (PITR)**
Restore the database to a specific point in time:
```sh
pg_restore -U myuser -d mydb -F c mydb_backup.dump
```
Then, apply WAL logs up to the desired point in time:
```sh
recovery_target_time = '2024-03-07 12:30:00'
restore_command = 'cp /var/lib/postgresql/wal_archive/%f %p'
```

Restart PostgreSQL:
```sh
sudo systemctl restart postgresql
```

---

## Streaming Replication and High Availability
### **1. Setting Up Streaming Replication**
Streaming replication keeps a **standby server** in sync with the primary.

#### **On Primary Server (`postgresql.conf`)**
```ini
wal_level = replica
max_wal_senders = 3
wal_keep_size = 1024
```

#### **On Primary Server (`pg_hba.conf`)**
```ini
host replication replica_user 192.168.1.2/32 md5
```

#### **On Standby Server**
```sh
pg_basebackup -h 192.168.1.1 -U replica_user -D /var/lib/postgresql/data -Fp -Xs -P
```
Create `recovery.conf`:
```ini
standby_mode = 'on'
primary_conninfo = 'host=192.168.1.1 port=5432 user=replica_user password=replicapassword'
```
Restart PostgreSQL on the standby server:
```sh
sudo systemctl restart postgresql
```

### **2. Using Patroni for Automatic Failover**
Patroni is a high-availability solution for PostgreSQL clusters.
```sh
patronictl -c /etc/patroni.yml list
patronictl -c /etc/patroni.yml switchover
```

---

