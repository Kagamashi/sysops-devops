
## **Bot Management and Rate Limiting**
### **Cloudflare Bot Management**
- Uses machine learning to detect and mitigate malicious bot traffic.
- Configurable bot score threshold for blocking automated threats.
- **Best Practice:** Allowlist trusted bots (e.g., Azure DevOps, monitoring tools).

### **Setting Up Rate Limiting Rules**
Rate limiting prevents excessive requests from overloading servers.

#### **Steps to Enable Rate Limiting**
1. Navigate to **Security → WAF → Rate Limiting**.
2. Click **Create Rule**.
3. Define conditions:
   - **URL Path**: `/api/*`
   - **Requests Per Minute**: `100`
   - **Action**: Block (after threshold is exceeded)
4. Click **Deploy**.

### **Example: Rate Limit API Traffic**
```yaml
Expression: (http.request.uri.path contains "/api/")
Threshold: 100 requests per minute
Action: Block
```

---
