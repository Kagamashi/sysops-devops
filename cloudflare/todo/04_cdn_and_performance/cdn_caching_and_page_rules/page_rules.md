
## **Using Cloudflare Page Rules for Custom Caching**
Cloudflare’s **Page Rules** allow fine-tuned control over caching behavior for specific URLs.

### **Creating a Page Rule**
1. Go to **Cloudflare Dashboard → Rules → Page Rules**.
2. Click **Create Page Rule**.
3. Define the URL pattern (e.g., `example.com/images/*`).
4. Set **Cache Level → Cache Everything**.
5. Adjust Edge Cache TTL (e.g., **1 day**).
6. Save the rule and deploy.

### **Example Page Rules for Caching Optimization**
| Rule | Action |
|------|--------|
| `example.com/images/*` | Cache everything, set Edge TTL to 1 day |
| `example.com/api/*` | Bypass cache to always fetch fresh content |
| `example.com/*` | Enforce HTTPS, redirect `www` to non-`www` |

---

## **Redirect Rules with Page Rules**
Cloudflare can be used for **301/302 redirects** without modifying Azure’s backend.

### **Example: Redirect `www.example.com` to `example.com`**
1. Create a Page Rule for `www.example.com/*`.
2. Select **Forwarding URL (301 Permanent Redirect)**.
3. Redirect to `https://example.com/$1`.
4. Save and deploy.

### **Example: Redirect HTTP to HTTPS**
- Enable **Always Use HTTPS** in Cloudflare’s SSL/TLS settings.
- Use a **Page Rule** for `http://example.com/*` → Redirect to `https://example.com/$1`.

---
