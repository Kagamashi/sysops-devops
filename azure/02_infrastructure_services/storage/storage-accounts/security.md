# Azure Storage Security Overview

Azure Storage provides built-in **encryption at rest**, **authentication/authorization** options, **secure transport**, and robust **key management** capabilities to help protect your data. Below are the key points and best practices.

---
## 1. Common Security Strategies
- **Encryption at Rest**: All data is automatically encrypted using 256-bit AES via Storage Service Encryption (SSE).
- **Authentication**: Uses Microsoft Entra ID (Azure AD) for fine-grained access control (RBAC). Supports Shared Key and SAS tokens.
- **Encryption in Transit**: Always use HTTPS (TLS). `Secure transfer required` ensures any HTTP request is refused.
- **Disk Encryption for VMs**: Azure Disk Encryption uses BitLocker (Windows) or dm-crypt (Linux). Keys managed in Azure Key Vault.
- **Authorization**: Requests to storage must be authorized. Options include Azure AD, Shared Key, SAS, or anonymous (where permitted).

---
## 2. Shared Access Signature (SAS)
A **SAS** grants restricted access to data in your storage account without exposing account keys.

### 2.1 SAS Benefits
- **Granular control**: Specify permissions (read/write/delete), IP restrictions, valid time range, and allowed protocols.
- **Delegated access**: Clients directly access storage instead of routing through a proxy.
- **Multiple levels**: Account-level SAS or service-level SAS.

### 2.2 SAS Considerations
- **Stored access policy** (optional) can group SAS and revoke them if needed.
- **Limit exposure**: Use the least permissions, short-lived durations, and IP restrictions.
- **Always use HTTPS** to create/distribute a SAS.
- Plan for **renewals**, clock skew.
- Validate data after it’s written.

---
## 3. Encryption & Key Management
- **Automatic**: Data is encrypted before storage, decrypted upon retrieval, no performance impact.
- **AES 256-bit**: Industry-standard block cipher.
- **Platform-Managed Keys (PMKs)**: Default, all behind the scenes.
- **Customer-Managed Keys (CMKs)**: In Azure Key Vault or HSM for full control over key lifecycle.
- **Infrastructure Encryption**: Optional double-encryption layer for extra security.

---
## 4. Security Best Practices

| Strategy                        | Description                                                                                       |
|--------------------------------|---------------------------------------------------------------------------------------------------|
| **Use Azure AD + RBAC**        | Assign roles, e.g., Storage Blob Contributor, to least-privileged users/groups/apps.              |
| **Enable HTTPS**               | Enforce `Secure transfer required`. No unencrypted traffic.                                        |
| **Rotate Access Keys**         | Regularly rotate and store in a secure location (Azure Key Vault recommended).                    |
| **Limit SAS Permissions**      | Restrict permissions, use near-term expiry, define IPs/HTTPS only, store policies if possible.     |
| **Monitor & Log**              | Use Azure Storage Analytics for spikes in authentication failures or suspicious activity.         |
| **Validate Data**              | If the application requires validated data, check data post-upload (especially for SAS writes).    |
| **Business Rules in Mid-Tier** | For highly sensitive ops, use a service to handle logic & authentication before writing to storage.|
