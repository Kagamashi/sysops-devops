
## **DNSSEC (Domain Name System Security Extensions)**
DNSSEC adds cryptographic signatures to DNS responses, protecting against DNS spoofing and cache poisoning.

### **How to Enable DNSSEC in Cloudflare (Azure Context)**
1. Go to **Cloudflare Dashboard → DNS → DNSSEC**.
2. Click **Enable DNSSEC**.
3. Copy the DS (Delegation Signer) record details.
4. Add the DS record to **Azure DNS or your domain registrar**.
5. Verify DNSSEC activation.

**Best Practice:** Always enable DNSSEC for public domains to improve security.

---
