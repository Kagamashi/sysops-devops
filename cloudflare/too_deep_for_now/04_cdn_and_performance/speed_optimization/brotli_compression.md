
## **Brotli Compression**
Brotli is a compression algorithm that reduces file sizes more efficiently than Gzip, improving load times.

### **How to Enable Brotli Compression**
1. Navigate to **Cloudflare Dashboard → Speed → Optimization**.
2. Enable **Brotli Compression**.

**Best Practice:**
- Ensure Azure backend services **support Brotli** (Azure Front Door and App Services support it natively).
- Keep Brotli enabled for all text-based assets (HTML, CSS, JS, JSON, XML).

---
