## **Microsoft Entra**  

### **Overview**
- **Microsoft Entra ID** is a **cloud-based identity and access management service** offered as a **PaaS** (Platform as a Service) by Microsoft.
- It is **not an on-prem AD DS replacement** but serves as a **modern identity management solution** for **cloud and hybrid environments**.
- Offers additional features like **Multi-Factor Authentication (MFA), identity protection, and self-service password reset**, which are not natively available in AD DS.

### **Key Features**
✅ **Identity and Access Management** – Securely manage users and groups.  
✅ **Single Sign-On (SSO)** – Provides seamless access to cloud-based apps.  
✅ **Federation** – Enables integration with on-prem AD DS or third-party identity providers.  
✅ **Conditional Access** – Restrict access based on device, location, and risk level.  
✅ **Application Proxy** – Securely extend on-prem applications to the cloud.  
✅ **Microsoft Entra Connect** – Syncs users from on-premises AD DS to Microsoft Entra ID.  
✅ **Audit & Monitoring** – Detects **irregular sign-ins** and provides security insights.  

### **Microsoft Entra Tenants**
- **Multi-tenant by design** – Ensures isolation between directory instances.
- Every **Azure subscription is linked to one Microsoft Entra tenant**.
- **A single tenant can manage multiple Azure subscriptions**, ensuring consistent identity management across environments.
- **Custom domains can be added** to replace the default "onmicrosoft.com" domain.

### **Microsoft Entra Schema**
- **Simplified compared to AD DS** – No support for **Organizational Units (OUs)** or **computer objects**.
- **Device-based identity** replaces traditional **computer accounts**.
- **Extensible schema** – Can be customized for additional attributes.
- **Application and Service Principal model** – Defines how applications authenticate and integrate across multiple tenants.

### **Microsoft Entra ID Versions**
| **Feature**                           | **Free** | **P1** | **P2** |
|--------------------------------|--------|--------|--------|
| **SSO & Basic IAM**            | ✅     | ✅     | ✅     |
| **Multi-Factor Authentication** | ✅     | ✅     | ✅     |
| **Conditional Access**          | ❌     | ✅     | ✅     |
| **Privileged Identity Management (PIM)** | ❌     | ❌     | ✅     |
| **Identity Protection**         | ❌     | ❌     | ✅     |
| **Self-Service Password Reset** | ❌     | ✅     | ✅     |
| **Connect Health Monitoring**   | ❌     | ✅     | ✅     |
| **Cloud App Discovery**         | ❌     | ✅     | ✅     |

### **Use Cases**
🔹 **Cloud Identity Management** – Secure access to cloud-based applications.  
🔹 **Hybrid Identity** – Extend **on-prem AD DS** to **Microsoft Entra ID**.  
🔹 **Enhanced Security** – Implement **MFA, Conditional Access, and Risk-Based Authentication**.  
🔹 **Application Integration** – Manage identity across **SaaS and custom applications**.  
🔹 **Privileged Access Management** – Use **PIM** to secure administrator access.  
