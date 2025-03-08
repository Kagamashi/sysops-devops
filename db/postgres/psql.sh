
## PSQL CLI
# conecting to database
psql -U postgres

# connect to specific database
psql -U user -d database


## PG_DUMP
# backup single database
pg_dump -U myuser -W -F c -f mydb_backup.dump mydb

# restore a database from backup
pg_restore -U myuser -d mydb -F c mydb_backup.dump

# backup all databases
pg_dumpall -U myuser -W -f all_databases_backup.sql
