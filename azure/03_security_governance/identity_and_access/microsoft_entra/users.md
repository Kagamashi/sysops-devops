## **Microsoft Entra Users**

### **Overview**
- Every user who needs access to Azure resources requires a **Microsoft Entra ID user account**.
- Authentication happens via **Microsoft Entra ID**, which then issues an **access token** to authorize user actions.
- Users are managed through the **Microsoft Entra ID dashboard** in the Azure portal.
- Administrators can switch directories using the **Directory + Subscription panel**.

### **Types of Users in Microsoft Entra ID**
Microsoft Entra ID categorizes users into three types based on their source:

1. **Cloud Identities** – Users who exist only in Microsoft Entra ID.
   - Examples: Administrator accounts and manually created user accounts.
   - Managed directly within **Microsoft Entra ID**.
   - Source: **Microsoft Entra ID or another Entra directory**.
   - When removed from the directory, they are **permanently deleted**.

2. **Directory-Synchronized Identities** – Users synchronized from an **on-premises AD DS** environment.
   - Managed via **Microsoft Entra Connect**, which syncs users from **Windows Server AD**.
   - Allows users to authenticate with the same credentials across on-prem and cloud environments.
   - Changes made on-premises are reflected in Microsoft Entra ID upon synchronization.

3. **Guest Users** – External users requiring access to Azure resources.
   - Examples: Contractors, vendors, Microsoft accounts (e.g., Xbox, Outlook), accounts from other cloud providers.
   - These accounts are created as **invited users** in Microsoft Entra ID.
   - Useful for **temporary access** to specific Azure services and applications.
   - Once their access is no longer required, they can be **removed**, revoking all permissions.

### **Managing Users in Microsoft Entra ID**
- **User accounts can be added manually or via bulk import.**
- **Role-based access control (RBAC)** determines the resources a user can access.
- **Conditional Access policies** enforce security requirements such as MFA.
- **Self-service password reset (SSPR)** enables users to reset passwords independently.

### **Viewing Users in Microsoft Entra ID**
1. Navigate to the **Azure Portal** → **Microsoft Entra ID**.
2. Select **Users** under **Identity**.
3. Use the **All Users** view to list and manage user accounts.
4. The **User Type** column distinguishes between **Members** and **Guests**.

### **Best Practices for Managing Users**
✅ **Use Groups for Access Management** – Instead of assigning permissions individually, use groups to simplify access control.
✅ **Implement Conditional Access** – Restrict access based on location, device compliance, and risk level.
✅ **Enable MFA** – Protect user accounts with multi-factor authentication.
✅ **Regularly Review Guest Access** – Ensure external users only have necessary permissions.
✅ **Monitor Sign-in Logs** – Use Microsoft Entra reports to detect suspicious login activity.
