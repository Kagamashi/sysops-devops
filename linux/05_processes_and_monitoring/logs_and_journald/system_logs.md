
## **System Logs in `/var/log/`**
Linux stores logs in `/var/log/`, where different components and services write their logs.

| Log File | Description |
|----------|-------------|
| `/var/log/syslog` | General system logs (Debian-based systems). |
| `/var/log/messages` | General system logs (RHEL-based systems). |
| `/var/log/auth.log` | Authentication logs (logins, sudo usage). |
| `/var/log/kern.log` | Kernel messages. |
| `/var/log/dmesg` | Boot logs and kernel ring buffer. |
| `/var/log/boot.log` | Boot process logs. |
| `/var/log/cron.log` | Cron job execution logs. |
| `/var/log/nginx/access.log` | Web server access logs. |
| `/var/log/nginx/error.log` | Web server error logs. |

To view logs:
```bash
cat /var/log/syslog
```
Or filter recent entries:
```bash
tail -f /var/log/auth.log
```

---
