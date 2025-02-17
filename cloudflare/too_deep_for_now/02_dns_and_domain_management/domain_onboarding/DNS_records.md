
## **Configuring DNS Records**
Once the domain is onboarded, configure DNS records within Cloudflare.

### **Common DNS Records**
| Record Type | Purpose |
|------------|---------|
| **A Record** | Maps a domain to an IP address (e.g., `example.com → 192.168.1.1`). |
| **CNAME Record** | Aliases one domain to another (e.g., `www.example.com → example.com`). |
| **MX Record** | Specifies mail servers for a domain (used for email routing). |
| **TXT Record** | Stores text-based information (e.g., SPF, DKIM, verification keys). |
| **NS Record** | Defines authoritative nameservers for the domain. |

### **Example DNS Setup in Cloudflare**
```yaml
- Type: A
  Name: example.com
  Value: 192.168.1.1
  Proxy Status: Proxied (Orange Cloud)

- Type: CNAME
  Name: www
  Value: example.com
  Proxy Status: Proxied (Orange Cloud)

- Type: MX
  Name: example.com
  Value: mail.example.com
  Priority: 10

- Type: TXT
  Name: example.com
  Value: "v=spf1 include:mail.example.com -all"
```

---
