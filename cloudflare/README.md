## Cloudflare

**Cloudflare** is a global cloud platform that provides **CDN, security, DDoS protection, DNS, and Zero Trust networking** solutions.

- **Official Docs**: [https://developers.cloudflare.com/](https://developers.cloudflare.com/)
- **GitHub Repos**: [https://github.com/cloudflare](https://github.com/cloudflare)
- **Cloudflare API**: [https://api.cloudflare.com/](https://api.cloudflare.com/)
- **CLI (Wrangler for Workers)**: [https://developers.cloudflare.com/workers/wrangler/](https://developers.cloudflare.com/workers/wrangler/)

---

### Dictionary

- **CDN (Content Delivery Network)**: A network of edge servers that cache and accelerate website content.
- **WAF (Web Application Firewall)**: Protects against OWASP Top 10 threats and custom rule-based attacks.
- **DNS (Domain Name System)**: Cloudflare’s **1.1.1.1** resolver provides fast, private, and secure DNS.
- **Zero Trust**: Security model ensuring users verify before accessing applications (**Cloudflare Access, Tunnel**).
- **DDoS Protection**: Always-on protection against volumetric, application-layer, and zero-day attacks.
- **Argo Smart Routing**: Improves network performance by routing traffic over the fastest path.
- **Cloudflare Workers**: A serverless platform for running JavaScript at the network edge.
- **Rate Limiting**: Prevents excessive requests to APIs or websites.
- **Page Rules & Transform Rules**: Custom URL handling, redirects, and rewrites.
- **API Gateway**: Secures, manages, and monitors APIs with authentication, caching, and rate-limiting.

---

### CRDs (Custom Resource Definitions)

Cloudflare **does not** natively use Kubernetes CRDs,  
but **Cloudflare Operator** can be used to manage settings from Kubernetes:

- **CloudflareTunnel**: CRD for Cloudflare Tunnel management.
- **CloudflareDNSRecord**: CRD for managing DNS records within Kubernetes.

---
