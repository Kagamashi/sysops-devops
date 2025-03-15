## **Microsoft Entra Domain Services**  

### **Overview**
- **Microsoft Entra Domain Services (EDS)** provides **Active Directory domain services (AD DS)** in Azure without needing domain controllers.
- Helps migrate **on-premises Line-of-Business (LOB) apps** to Azure without requiring a VPN or managing domain controllers.
- Supports **LDAP, NTLM, and Kerberos authentication** for cloud-based applications.
- Works with **Microsoft Entra ID P1/P2** and integrates with **on-prem AD DS** via **Microsoft Entra Connect**.

### **Deployment Options**
1. **Traditional VPN + On-Prem AD DS**  
   - Uses a **site-to-site VPN** for authentication traffic.  
   - Requires **on-prem domain controllers**.  
   - Authentication traffic flows over the VPN.
  
2. **Replica Domain Controllers in Azure**  
   - Deploys **domain controllers as Azure VMs**.  
   - Requires **replication traffic over the VPN**, but authentication stays in the cloud.  
   - Adds **administrative overhead** for managing domain controllers.

3. **Microsoft Entra Domain Services (Recommended)**
   - **No need to deploy/manage domain controllers** in Azure.  
   - **Provides domain join, Group Policy, Kerberos, and NTLM authentication**.  
   - **Supports hybrid or cloud-only** identity models.  
   - **Works with Azure VMs** to run applications like **SQL Server and SharePoint**.  
   - **Fully managed service** with automatic updates and maintenance.

### **Benefits**
✅ **No need to manage domain controllers** (DCs are handled by Microsoft).  
✅ **No need for manual AD DS replication** (Microsoft synchronizes users from Microsoft Entra ID).  
✅ **Seamless integration with on-prem AD DS** via **Microsoft Entra Connect**.  
✅ **Supports domain-joining Azure VMs**, including Windows/Linux.  
✅ **Fully compatible with Group Policy, NTLM, Kerberos, and LDAP applications**.  

### **Limitations**
❌ **Only supports base computer AD object** (no extensions).  
❌ **Schema extensions are not possible** (unlike on-prem AD DS).  
❌ **Flat OU structure** (nested OUs are **not** supported).  
❌ **Built-in Group Policy Objects (GPOs) only** (cannot create custom GPOs or target specific OUs).  
❌ **No Windows Management Instrumentation (WMI) or security-group filtering** for policies.  

### **Use Cases**
🔹 Migrating **legacy apps** to Azure without needing a **VPN or domain controllers**.  
🔹 Running **SQL Server, SharePoint, or other AD-integrated apps** on Azure VMs.  
🔹 Providing **cloud-based authentication** for applications using **Kerberos, NTLM, or LDAP**.  
🔹 Enabling **domain-join capabilities** for **Azure Virtual Machines**.  

### **Pricing**
💲 **Charged per hour** based on **directory size**.  
