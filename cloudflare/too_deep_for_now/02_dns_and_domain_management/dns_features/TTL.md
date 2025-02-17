
## **TTL (Time to Live) Settings**
TTL determines how long a DNS record is cached before refreshing.

### **Recommended TTL Settings**
| Record Type | Recommended TTL |
|------------|----------------|
| A/CNAME | 300s (5 min) - Dynamic services |
| MX | 3600s (1 hour) - Mail servers |
| TXT | 3600s (1 hour) - Verification records |
| NS | 86400s (24 hours) - Nameserver records |

- **Lower TTL (300s - 600s)**: Best for frequently changing records (e.g., web servers, failover setups).
- **Higher TTL (3600s - 86400s)**: Best for static records like MX, NS, and TXT.

---
