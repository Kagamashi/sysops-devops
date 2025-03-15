## **Syslog Basics and Alternative Logging Solutions**
Syslog is a **standard logging protocol** used by many Linux systems.

### **Syslog Implementations**
| Syslog Service | Description |
|---------------|-------------|
| `rsyslog` | Default syslog service in most Linux distributions. |
| `syslog-ng` | Advanced logging with filtering and remote logging. |
| `journald` | Systemd-based logging system. |

### **Managing `rsyslog`**
- Configuration file: `/etc/rsyslog.conf`
- Restart the service after changes:
  ```bash
  sudo systemctl restart rsyslog
  ```
- Send logs to a remote server:
  ```plaintext
  *.* @logserver.example.com:514
  ```

### **Alternative Logging Solutions**
| Tool | Purpose |
|------|---------|
| `logstash` | Collects, filters, and forwards logs (used with Elasticsearch). |
| `fluentd` | Log aggregation and forwarding. |
| `graylog` | Centralized log management system. |
| `ELK Stack` | Elasticsearch + Logstash + Kibana for log visualization. |

---
