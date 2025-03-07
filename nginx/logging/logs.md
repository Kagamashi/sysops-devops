
## Access and Error Logs

#### Understanding `access.log` and `error.log`
- **`access.log`** → Records all incoming requests, including status codes, request times, and client IPs.
- **`error.log`** → Stores error messages related to server failures, misconfigurations, and request handling issues.

#### Configuring Custom Log Formats
Customize log formats for better debugging and analysis:
```nginx
log_format custom '$remote_addr - $remote_user [$time_local] "$request" '
                  '$status $body_bytes_sent "$http_referer" '
                  '"$http_user_agent" "$http_x_forwarded_for"';
access_log /var/log/nginx/custom_access.log custom;
```
- **`log_format custom`** → Defines a custom log format.
- **`access_log custom_access.log`** → Stores logs in a custom file.

---

## Log Rotation and File Handling

### Reducing Log File Sizes
Log files can grow large over time, consuming disk space. To control log file sizes, configure log file compression and rotation.
```nginx
log_format main '$remote_addr - $remote_user [$time_local] "$request" '
                '$status $body_bytes_sent "$http_referer" '
                '"$http_user_agent" "$http_x_forwarded_for"';
access_log /var/log/nginx/access.log main buffer=16k flush=5s;
```
- **`buffer=16k`** → Buffers logs in memory to reduce disk writes.
- **`flush=5s`** → Writes logs to disk every 5 seconds to balance performance and persistence.

### Setting Up Log Rotation with logrotate
To automatically rotate logs, use `logrotate`. Create or modify the `/etc/logrotate.d/nginx` configuration:
```nginx
/var/log/nginx/*.log {
    daily
    missingok
    rotate 14
    compress
    delaycompress
    notifempty
    create 0640 www-data adm
    sharedscripts
    postrotate
        systemctl reload nginx > /dev/null 2>&1 || true
    endscript
}
```
- **`daily`** → Rotates logs every day.
- **`rotate 14`** → Keeps logs for 14 days before deleting old ones.
- **`compress`** → Compresses logs to save space.
- **`delaycompress`** → Delays compression by one rotation cycle.
- **`notifempty`** → Skips rotation if the log file is empty.
- **`postrotate`** → Reloads NGINX after log rotation to ensure proper logging.
