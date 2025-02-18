
# Check Cluster Health
curl -X GET "https://your-cluster:9200/_cluster/health?pretty" -u user:password

# Create a New Index
curl -X PUT "https://your-cluster:9200/logs-2024-02" -H 'Content-Type: application/json' -d'{
  "settings": { "number_of_shards": 3, "number_of_replicas": 1 }
}' -u user:password

# Delete an Index
curl -X DELETE "https://your-cluster:9200/logs-2024-02" -u user:password

# Scaling Nodes in the Cluster
curl -X PUT "https://your-cluster:9200/_cluster/settings" -H 'Content-Type: application/json' -d'{
  "persistent": { "cluster.routing.allocation.enable": "all" }
}' -u user:password

# Backup (Snapshot) a Cluster
curl -X PUT "https://your-cluster:9200/_snapshot/my_backup" -H 'Content-Type: application/json' -d'{
  "type": "fs",
  "settings": { "location": "/mnt/backups", "compress": true }
}' -u user:password

# Restoring from a Snapshot
curl -X POST "https://your-cluster:9200/_snapshot/my_backup/snapshot_01/_restore" -H 'Content-Type: application/json' -d'{
  "indices": "logs-*",
  "ignore_unavailable": true,
  "include_global_state": false
}' -u user:password
