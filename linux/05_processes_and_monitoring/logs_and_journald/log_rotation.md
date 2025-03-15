
## **Log Rotation (`logrotate`)**
Log files can grow large; `logrotate` **automatically manages log rotation, compression, and deletion**.

### **Configuring Log Rotation**
Log rotation rules are stored in `/etc/logrotate.conf` and `/etc/logrotate.d/`.
Example `/etc/logrotate.d/custom-log` configuration:
```plaintext
/var/log/custom-app.log {
    weekly
    rotate 4
    compress
    missingok
    notifempty
}
```

### **Common `logrotate` Options**
| Option | Description |
|--------|-------------|
| `weekly` | Rotate logs every week. |
| `rotate 4` | Keep the last 4 log files. |
| `compress` | Compress old log files. |
| `missingok` | Ignore errors if the log file is missing. |
| `notifempty` | Skip rotation if the file is empty. |

To manually test log rotation:
```bash
sudo logrotate -f /etc/logrotate.conf
```

---
