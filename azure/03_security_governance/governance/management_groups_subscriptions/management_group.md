## **Azure Management Infrastructure**

### **Overview**
- Azure’s management infrastructure includes **resources, resource groups, subscriptions, and management groups**.
- Understanding this hierarchy helps in efficient planning, governance, and cost management.

---

## **Azure Resources & Resource Groups**
### **Resources**
- A **resource** is any Azure service you provision (e.g., VMs, databases, storage accounts, networks).
- Resources must be placed within a **resource group**.

### **Resource Groups**
- A logical container for resources that share the same **lifecycle, permissions, and policies**.
- Key characteristics:
  - A resource **belongs to only one resource group**.
  - **Resource groups cannot be nested**.
  - Moving a resource **to another group removes it from the previous one**.
  - **Deleting a resource group deletes all resources within it**.

✅ **Best Practice:** Group resources by function, access needs, or environment (e.g., dev, test, prod).

---

## **Azure Subscriptions**
- A **subscription** is a logical container for organizing **resource groups and billing**.
- Every Azure account must have at least **one subscription**.
- **Subscriptions link to a Microsoft Entra ID account** for authentication and authorization.

### **Subscription Boundaries**
1. **Billing Boundary:** Determines how usage costs are grouped and billed.
2. **Access Control Boundary:** Defines access policies and security at the subscription level.

### **Reasons to Create Additional Subscriptions**
- **Separate Environments:** Isolate dev, test, and production workloads.
- **Departmental Billing:** Allocate costs to different business units.
- **Access Management:** Apply different policies and security measures per subscription.

✅ **Best Practice:** Use **multiple subscriptions** to isolate workloads and improve cost tracking.

---

## **Azure Management Groups**
- **Management groups** provide a higher-level organizational structure **above subscriptions**.
- They help apply **governance policies, security, and compliance** across multiple subscriptions.
- **Subscriptions inherit policies** from management groups.
- Management groups **can be nested** up to **six levels** deep.

### **Use Cases**
- **Apply global policies** (e.g., restrict VM locations to a specific region).
- **Centralized access control** (assign Azure RBAC at the management group level).
- **Governance at scale** (manage thousands of subscriptions efficiently).

### **Important Facts**
- Up to **10,000 management groups** can exist in a single directory.
- **Each management group can have only one parent**.
- **Subscriptions can only be part of one management group**.

✅ **Best Practice:** Structure management groups based on **business units, compliance needs, or workload types**.

---

## **Conclusion**
Azure’s **hierarchical management model** helps organizations streamline **resource organization, billing, governance, and security**:
1. **Resources** → smallest unit (VMs, databases, etc.).
2. **Resource Groups** → logical containers for resources.
3. **Subscriptions** → billing & access control boundaries.
4. **Management Groups** → governance & policy enforcement at scale.

