
## **Changing Nameservers to Cloudflare**
To use Cloudflare for DNS management, you need to update your domain’s nameservers.

### **Steps to Change Nameservers**
1. **Add your domain to Cloudflare**:
   - Log in to the Cloudflare dashboard.
   - Click **Add a Site** and enter your domain name.
   - Cloudflare will scan existing DNS records.
2. **Select a Cloudflare Plan** (Free, Pro, Business, or Enterprise).
3. **Cloudflare provides new nameservers** (e.g., `bob.ns.cloudflare.com`, `alice.ns.cloudflare.com`).
4. **Update Nameservers at Your Domain Registrar**:
   - Go to your domain registrar (e.g., Azure DNS, GoDaddy, Namecheap).
   - Replace the existing nameservers with Cloudflare’s provided nameservers.
5. **Verify Nameserver Change in Cloudflare**:
   - Cloudflare will detect the update (can take up to 24 hours).
   - Once verified, Cloudflare DNS management is active.

---
