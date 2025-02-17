
## **Proxied vs. DNS-Only Records**
Cloudflare offers two DNS modes for records:

### **Proxied Mode (Orange Cloud ☁️)**
- Traffic is routed through Cloudflare’s network.
- Provides DDoS protection, caching, and performance optimization.
- Masks the origin server’s IP address.
- Example Use Case: Web servers, APIs, public-facing applications.

### **DNS-Only Mode (Grey Cloud ☁️)**
- Traffic goes directly to the origin server.
- No Cloudflare security or performance benefits.
- Best for services requiring direct IP access (e.g., mail servers, VPNs).
- Example Use Case: MX records, SSH access, internal services.

#### **Example Configuration:**
```yaml
- Type: A
  Name: example.com
  Value: 192.168.1.1
  Proxy Status: Proxied

- Type: MX
  Name: example.com
  Value: mail.example.com
  Proxy Status: DNS Only
```

---
