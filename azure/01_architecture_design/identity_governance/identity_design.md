## Azure Identity and Access Management (IAM) Summary

### Overview
Identity and Access Management (IAM) in Azure ensures secure authentication and authorization for users, applications, and devices. A strong IAM solution provides unified identity management, adaptive security, simplified governance, and a seamless user experience.

#### Key IAM Principles:
- **Unified Identity Management:** Manage identities centrally for cloud and on-premises applications.
- **Seamless User Experience:** Provide fast and easy sign-in while reducing password-related issues.
- **Secure Adaptive Access:** Enforce strong authentication and risk-based policies.
- **Simplified Identity Governance:** Control access through automated identity governance.

### Microsoft Entra ID (Azure AD)
Microsoft Entra ID is Azure’s IAM solution that integrates directory services, application access management, and identity protection.

#### Features:
- Supports **cloud-only** or **hybrid** identity models.
- Offers **Role-Based Access Control (RBAC), conditional access, and access reviews**.
- Extends **on-premises Active Directory to Azure** via Entra Connect or cloud sync.

#### Best Practices:
- **Centralized Identity Management:** Manage accounts from a single location.
- **Use a Single Entra Instance:** Reduce complexity and security risks.
- **Limit High-Privilege Synchronization:** Protect high-privilege accounts.
- **Enable Password Hash Sync:** Prevent credential leaks.
- **Implement Single Sign-On (SSO):** Reduce password fatigue and improve security.
- **Minimize Separate Identities:** Avoid overhead and security risks from multiple identity stores.

### Microsoft Entra Business-to-Business (B2B)
Microsoft Entra B2B enables secure collaboration with external partners by inviting them as guest users.

#### Key Features:
- Partners use their own identity provider (no need to manage external credentials).
- Guest users access assigned applications via email invitation.
- Supports **multi-factor authentication (MFA)** for extra security.
- Enforces **conditional access policies** to regulate guest access.

#### Best Practices:
- **Delegate Guest User Management:** Assign app owners to handle guest access.
- **Implement Conditional Access:** Enforce access controls beyond passwords.
- **Leverage Identity Providers:** Allow users to sign in via social or enterprise accounts.
- **Use Self-Service Sign-Up:** Enable automated onboarding for B2B users.

### Microsoft Entra Business-to-Customer (B2C)
Microsoft Entra B2C provides identity management for customer applications, separate from an organization’s internal Entra directory.

#### Key Features:
- Supports **multiple identity providers** (e.g., Microsoft, Google, Facebook).
- Provides **custom user journeys** for registration and authentication.
- Stores **customer attributes** for personalized application experiences.
- Offers **custom UI branding** for sign-in and registration pages.
- Allows integration with **external user stores** for advanced authentication.

#### Best Practices:
- **Reuse User Flows:** Maintain consistency across different apps.
- **Support Social Logins:** Reduce barriers to user sign-in.
- **Customize Branding:** Provide a seamless and branded user experience.
- **Integrate with External Systems:** Store user data in external CRMs if needed.
- **Enable Identity Verification:** Use third-party proofing for secure onboarding.

### Comparing Microsoft Entra B2B vs. B2C
| Feature | Microsoft Entra B2B | Microsoft Entra B2C |
|---------|-----------------|-----------------|
| Use Case | Collaborate with external business partners | Manage customer identities |
| Identity Management | External partners use their own identity provider | Customers sign in via social or enterprise identities |
| User Management | Managed as guest users within the organization | Managed in a separate B2C tenant |
| Branding | Limited customization | Full UI customization |
| Access Control | Conditional access and RBAC policies | User flow configurations |

Azure IAM solutions ensure secure access management across internal users, business partners, and customers, aligning with modern security and compliance standards.

---

## Azure Conditional Access and Identity Protection Summary

### Conditional Access

Conditional Access in Microsoft Entra ID controls access to resources based on user identity, location, device, and risk assessment. It allows organizations to implement adaptive authentication measures such as Multi-Factor Authentication (MFA) or block access when necessary.

#### Key Features:
- **Granular MFA Control:** Apply MFA only when necessary, based on risk assessment.
- **Named Locations:** Restrict access from unexpected geographical areas.
- **Device Compliance Enforcement:** Limit access to managed and secure devices.
- **Approved Client Apps:** Restrict access to applications that meet security standards.
- **Blocking Untrusted Sources:** Prevent access from unknown or high-risk locations.
- **Report-Only Mode:** Test policies before enforcing them.
- **What If Tool:** Simulate policy impact before deployment.

#### Best Practices:
- Require MFA for high-risk sign-ins.
- Restrict access from specific geographic areas.
- Enforce access from only compliant devices and applications.
- Block legacy authentication protocols to prevent security vulnerabilities.
- Use Report-Only mode for policy testing before enforcement.

### Identity Protection

Microsoft Entra Identity Protection automates detection and remediation of identity risks by analyzing user behavior and identifying potential security threats.

#### Risk Policies:
- **User Risk:** Measures the likelihood that an identity is compromised.
- **Sign-in Risk:** Evaluates if a login attempt is fraudulent or unusual.

#### Risk Signals:
- **Leaked Credentials:** Checks compromised credentials from external sources.
- **Anonymous IP Address:** Flags logins from anonymous proxies like Tor.
- **Atypical Travel:** Detects impossible travel scenarios.
- **Malware-linked IPs:** Identifies logins from compromised systems.
- **Password Spray Attacks:** Detects credential stuffing attempts.

#### Best Practices:
- Set user risk policy threshold to **High** to detect credential leaks and unusual activity.
- Configure sign-in risk policy to **Medium and above** to trigger additional security measures.
- Investigate risk events through the Azure portal and export data for further analysis.
- Integrate risk detection with SIEM tools like Microsoft Sentinel.

### Access Reviews

Access Reviews ensure that users maintain appropriate permissions over time, mitigating risks associated with excessive access privileges.

#### Key Features:
- Review access to applications, groups, and roles.
- Automate removal of inactive accounts.
- Assign resource owners, delegates, or end users as reviewers.
- Implement automatic actions for unreviewed accounts.

#### Best Practices:
- Conduct periodic access reviews for critical resources.
- Automate removal of users who haven't logged in for a set period.
- Notify reviewers in advance to ensure timely completion of reviews.

### Service Principals

Service principals define application permissions in Microsoft Entra ID. They act as the identity for applications and services within Azure.

#### Types of Service Principals:
- **Application Service Principal:** Represents a single application instance in a tenant.
- **Managed Identity Service Principal:** Used for Azure resources to authenticate without managing credentials.
- **Legacy Service Principal:** For applications created before modern app registrations.

#### Best Practices:
- Use managed identities to reduce credential exposure.
- Grant only the minimum necessary permissions.
- Restrict user consent for external applications to improve security.

By implementing Conditional Access, Identity Protection, and access reviews, organizations can enhance security while maintaining a seamless user experience in Azure environments.


---

## Azure Managed Identities and Key Vault Summary

### Managed Identities

Managed Identities in Microsoft Entra ID simplify secure authentication between Azure resources without requiring credentials management. They are available at no additional cost and eliminate the need for credential rotation.

#### Key Features:
- Provides an identity for applications to authenticate with Azure resources.
- Supports all Microsoft Entra ID editions, including the free tier.
- Uses Microsoft Entra tokens for authentication.
- Integrated with Azure App Service, Azure Virtual Machines, Azure Functions, and more.

#### Types of Managed Identities:
1. **System-Assigned Managed Identity:**
   - Created for a specific resource and tied to its lifecycle.
   - Automatically deleted when the resource is removed.
   - Used only by the assigned Azure resource.

2. **User-Assigned Managed Identity:**
   - Created as a separate Azure resource.
   - Can be assigned to multiple Azure resources.
   - Persistent even if assigned resources are deleted.

#### Best Practices:
- **Use System-Assigned Identities** for single-instance workloads.
- **Use User-Assigned Identities** for multiple resources sharing the same credentials.
- **Leverage RBAC** for fine-grained access control.
- **Monitor usage** through Azure Activity Logs and Microsoft Entra Sign-In Logs.
- **Authenticate Azure services** using managed identities to avoid storing credentials in code.

### Azure Key Vault

Azure Key Vault provides a secure environment for managing secrets, encryption keys, and certificates, reducing the risk of exposure.

#### Key Features:
- Centralized storage for tokens, passwords, API keys, and certificates.
- Two service tiers:
  - **Standard:** Software-based encryption.
  - **Premium:** Hardware Security Module (HSM)-backed encryption.
- Built-in access policies with granular control.
- Integration with Managed Identities for secure access.

#### Best Practices:
- **Use Separate Key Vaults** to define security boundaries for applications.
- **Restrict Access:** Apply least privilege access policies.
- **Enable Firewall and Virtual Network Rules** for added security.
- **Turn on Soft Delete and Purge Protection:**
  - Soft delete protects against accidental deletion.
  - Purge protection prevents malicious deletions.

By using Managed Identities and Azure Key Vault together, organizations can enhance security and streamline authentication for cloud-based applications.


