## **Microsoft Entra Groups**

### **Overview**
- Microsoft Entra groups help **organize users** to simplify permission management.
- Instead of assigning permissions individually, groups allow **bulk assignment** of access rights.
- Groups define **security boundaries**, making it easier to grant or revoke access.
- Microsoft Entra ID supports **dynamic membership rules**, which automate group membership based on user attributes.

### **Types of Groups in Microsoft Entra ID**
Microsoft Entra ID offers two types of groups:

1. **Security Groups**
   - The most common type, used to **manage access** to shared resources.
   - Helps enforce security policies for multiple users at once.
   - Requires a **Microsoft Entra administrator** to create and manage.

2. **Microsoft 365 Groups**
   - Focused on **collaboration** and **productivity**.
   - Grants members access to a **shared mailbox, calendar, files, SharePoint site**, and more.
   - Can include **external users**, unlike security groups.
   - Can be created by both users and administrators.

### **Viewing Groups in Microsoft Entra ID**
1. Navigate to the **Azure Portal** → **Microsoft Entra ID**.
2. Select **Groups** under **Identity**.
3. The **All Groups** view displays existing groups.
4. A new Microsoft Entra ID deployment **does not contain predefined groups**.

### **Membership Types in Groups**
Microsoft Entra ID supports **two types of group membership management**:

1. **Assigned Groups**
   - Members are **manually added** by an administrator.
   - Membership does not change unless explicitly modified.

2. **Dynamic Groups**
   - Membership is controlled by **rules** that automatically add or remove users based on attributes.
   - Users are included if their attributes (e.g., department, job title) match the rule criteria.
   - Reduces administrative effort by **automating membership changes**.

### **Dynamic Groups – How They Work**
- Membership is updated **each time the group is used**.
- Users matching the rule automatically become members.
- If a user’s attributes change, they may be **added or removed automatically**.
- Helps **reduce errors** in access management by ensuring group membership is always up to date.

### **Best Practices for Managing Groups**
✅ **Use Security Groups for Access Control** – Apply permissions at the group level instead of individual users.
✅ **Utilize Microsoft 365 Groups for Collaboration** – Enable teams to work together with shared resources.
✅ **Leverage Dynamic Groups for Automation** – Minimize manual user management with rule-based memberships.
✅ **Regularly Audit Group Membership** – Ensure only the right users have access to sensitive resources.
✅ **Monitor Group Activity** – Use logs to detect unauthorized changes.
