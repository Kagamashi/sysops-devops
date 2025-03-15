
## **Host Entries (`/etc/hosts`)**
The `/etc/hosts` file maps hostnames to IP addresses **before querying DNS**.

### **Example `/etc/hosts` Entry:**
```plaintext
127.0.0.1   localhost
192.168.1.10  myserver.local myserver
```

To manually test host resolution:
```bash
ping myserver
```

---
