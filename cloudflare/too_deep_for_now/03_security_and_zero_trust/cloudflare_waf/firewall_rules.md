
## **Creating Cloudflare Firewall Rules**
Firewall rules define how traffic is allowed, blocked, or challenged based on request parameters.

### **Steps to Create a Firewall Rule**
1. Go to **Cloudflare Dashboard → Security → WAF → Firewall Rules**.
2. Click **Create a Firewall Rule**.
3. Define rule conditions (e.g., block traffic from specific IP ranges, countries, or user agents).
4. Choose an action:
   - **Allow** (Bypass rule checks)
   - **Block** (Deny access)
   - **Challenge (CAPTCHA)** (Verify user legitimacy)
   - **Log** (Track requests without enforcement)
5. Click **Deploy**.

### **Example: Block Traffic from a Specific Country**
```yaml
Expression: (ip.geoip.country eq "RU")
Action: Block
```

### **Example: Allow Azure DevOps Webhooks**
```yaml
Expression: (http.host eq "devops.example.com" and ip.src in {"13.107.6.183", "13.107.9.183"})
Action: Allow
```

---
