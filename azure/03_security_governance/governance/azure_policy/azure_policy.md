## **Azure Policies – Summary Notes**

### **Overview**
- **Azure Policies** enforce organizational standards and ensure compliance at scale.
- Used to **manage and control** Azure resources by defining rules and best practices.
- Evaluates **existing and new resources** to check compliance with policies.
- Policies are applied at different levels: **Management Groups, Subscriptions, Resource Groups, and Resources**.
- Supports both **built-in and custom policies**.

Everything about definitions:
# https://learn.microsoft.com/pl-pl/training/modules/sovereignty-policy-initiatives/azure-policy-definitions


---

## **Hierarchy for Governance**
### **Management Levels in Azure**
1. **Management Groups** – Top-level scope to apply policies across multiple subscriptions.
2. **Subscriptions** – Logical containers for resource groups; used for billing and access control.
3. **Resource Groups** – Grouping of related resources for unified management.
4. **Resources** – Individual Azure services like VMs, databases, and networking components.

✅ **Inheritance:** Policies applied at a higher level are automatically inherited by lower levels.

---

## **Azure Resource Manager (ARM) & Policy Enforcement**
- **Azure Resource Manager (ARM)** manages resources through **control plane** and **data plane** operations.
- **Control Plane:** Governs resource creation, updates, and deletion using policies.
- **Data Plane:** Handles direct access to resource data (e.g., accessing a storage account).
- **Azure Policy operates in the control plane** to enforce compliance rules.

✅ **Greenfield Deployment:** Policies exist before resource creation, ensuring compliance from the start.
✅ **Brownfield Deployment:** Policies are applied to existing resources, triggering compliance scans.

---

## **Key Azure Policy Concepts**
### **1. Policy Definitions**
- Defines the compliance conditions and actions to take if conditions are met.
- Applied at **Management Groups, Subscriptions, Resource Groups, or Resources**.
- **Effects:**
  - **Deny** – Prevents non-compliant resources from being created.
  - **Audit** – Flags non-compliant resources without blocking them.
  - **Append** – Adds additional settings to resources.
  - **Modify** – Alters settings of non-compliant resources.
  - **DeployIfNotExists** – Deploys missing configurations.

### **2. Initiatives (Policy Sets)**
- **Grouping of multiple policy definitions** to streamline policy assignments.
- Helps manage compliance at scale for regulatory frameworks and best practices.

### **3. Policy Assignments**
- Defines **where a policy or initiative applies** (e.g., a subscription, resource group, or specific resource).
- **Scopes:**
  - **Inclusions:** Determines resources to evaluate.
  - **Exclusions:** Allows certain resources to be excluded from policy enforcement.

### **4. Exemptions**
- Temporarily excludes specific resources from policy enforcement.
- **Types:**
  - **Mitigated:** Compliance is met via another method.
  - **Waiver:** Temporary acceptance of non-compliance.

### **5. Remediations**
- **Remediation tasks** bring non-compliant resources into compliance.
- **Required for:**
  - Modify policies.
  - DeployIfNotExists policies.
  - Resources created before policy enforcement.

✅ **Example:** Automatically applying encryption settings to an existing storage account.

### **6. Attestations**
- Used for manually defining compliance status when **automatic enforcement isn’t applicable**.
- Helps organizations track **manual approvals** of compliance measures.

---

## **Azure Policy Built-In vs. Custom Policies**
| Type | Description |
|------|-------------|
| **Built-In Policy** | Predefined by Azure for common compliance needs (e.g., enforce tagging). |
| **Custom Policy** | Created by organizations for specific governance requirements. |

---

## **Best Practices for Implementing Azure Policies**
✅ **Use Initiatives for Large-Scale Compliance** – Simplifies assigning multiple related policies.
✅ **Apply Policies at Higher Levels** – Use **Management Groups** to enforce consistency across subscriptions.
✅ **Monitor Policy Compliance** – Use **Azure Policy Compliance Dashboard** to track adherence.
✅ **Use DeployIfNotExists Carefully** – Requires managed identity permissions to apply changes.
✅ **Leverage Azure DevOps Integration** – Enforce policies within CI/CD pipelines.

---

## **Example Policy Use Cases**
- **Enforce Resource Location:** Prevents resources from being deployed outside allowed regions.
- **Restrict VM Sizes:** Ensures only cost-effective VM sizes are used.
- **Require Tags on Resources:** Ensures resources are properly categorized for cost tracking.
- **Ensure Encryption on Storage Accounts:** Blocks storage accounts without encryption enabled.

---

1. **Evaluation Triggers & Timing**  
   - **Triggers**: New/updated policy assignments, resource creation/updates, subscription creation/moves, policy exemptions changes.  
   - **Timing**:  
     - Automatic full scan every 24 hours  
     - Manual on-demand scan (`az policy state trigger-scan`)  
     - ~30-minute delay when newly assigning a policy (due to ARM cache)  
     - Scan completion time depends on policy complexity, scope size, and system load  

2. **Resource Compliance States**  
   - Possible states: Non-compliant, Compliant, Error, Conflicting, Protected, Exempted, Unknown  
   - Overall compliance is the combination of these states  
   - Compliance % = (Compliant + Exempt + Unknown) / All relevant resources  

3. **Enforcement Mode**  
   - **Enabled (Default)**: Policy effect is fully enforced (deny, modify, etc.)  
   - **DoNotEnforce (Disabled)**: Policy evaluation occurs, but effect isn’t enforced (useful for testing)  
   - Remediation can still happen even if enforcementMode is disabled  

4. **Safe Deployment & Best Practices**  
   - **What If/Testing**: Assign policies with enforcementMode disabled first to observe outcomes without enforcing or denying actions  
   - **Deployment Rings**: Gradually expand policy scope from test/dev to production in “rings” to minimize disruptions  
   - **Policy as Code**: Keep definitions in source control, automate testing before production  

5. **Reacting to Policy State Changes**  
   - Azure Policy events can trigger actions via **Azure Event Grid**  
   - Reliable event delivery, retry policies, and multiple handler options (Functions, Logic Apps, custom webhooks)  
   - Enables automation or custom notifications on policy compliance changes  

