## cert-manager

**cert-manager** is a Kubernetes add-on that **automates** the creation and management of **TLS certificates** from various Certificate Authorities (CAs). It helps ensure that certificates are **renewed** and **valid**.

- **Official Docs**: [https://cert-manager.io/docs/](https://cert-manager.io/docs/)
- **GitHub Repository**: [https://github.com/cert-manager/cert-manager](https://github.com/cert-manager/cert-manager)
- **Installation Guides**: [https://cert-manager.io/docs/installation/](https://cert-manager.io/docs/installation/)
- **FAQ**: [https://cert-manager.io/docs/faq/](https://cert-manager.io/docs/faq/)

---

### Dictionary

- **Issuer / ClusterIssuer**: CRDs that define **how** certificates are obtained.  
  - **Issuer** is namespace-scoped.  
  - **ClusterIssuer** is cluster-wide.
- **Certificate**: A CRD that specifies **what** certificate you need: domains, secret name, issuer reference, etc.
- **CertificateRequest**: An internal CRD representing a request to an Issuer or ClusterIssuer to issue a certificate.
- **ACME**: Protocol (used by Let’s Encrypt) that automates domain ownership validation.
- **Challenge** & **Order**: The ACME workflow to prove domain ownership and finalize the certificate issuance.

---

### CRDs (Custom Resource Definitions)

cert-manager introduces several CRDs:

1. **Issuer** (namespaced) and **ClusterIssuer** (cluster-scoped)  
   - Providers: ACME (Let’s Encrypt), SelfSigned, Vault, CA, etc.
2. **Certificate**  
   - Defines the desired certificate spec (domains, secret location).
3. **CertificateRequest** / **Order** / **Challenge**  
   - Internal resources used for the ACME issuance process.

---
