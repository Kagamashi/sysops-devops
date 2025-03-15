
## **DNS Configuration (`/etc/resolv.conf`)**
The `/etc/resolv.conf` file controls **DNS resolution**.

### **Example `/etc/resolv.conf` Configuration:**
```plaintext
nameserver 8.8.8.8
nameserver 1.1.1.1
options timeout:1 attempts:3
```
| Option | Description |
|--------|-------------|
| `nameserver` | Specifies a DNS server. |
| `search domain.com` | Appends domain for unqualified names. |
| `options timeout:1` | Time (seconds) before trying another DNS. |

To manually test DNS resolution:
```bash
nslookup example.com
host example.com
```

---
