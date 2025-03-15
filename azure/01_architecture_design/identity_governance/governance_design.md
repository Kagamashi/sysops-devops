# Azure Management Design

## Management Groups
Management groups help **manage access, policy, and compliance** across multiple subscriptions. They:
- Limit VM creation regions across subscriptions.
- Provide user access via **role assignments inherited** by multiple subscriptions.
- Enable **monitoring and auditing** of roles and policies across subscriptions.

### **Best Practices for Management Groups**
- Use **Azure Policy** to apply governance at scale.
- Maintain a **hierarchy of 3-4 levels** for flexibility and manageability.
- Implement a **top-level management group** for organization-wide policies.
- Structure groups by **departments, geography, workload type, or sensitivity**.
- Create **sandbox management groups** for testing isolated from production.

---

## Subscriptions
Azure subscriptions serve as **logical containers** for managing resources, billing, and compliance. They:
- Enable separate billing environments (e.g., **development, test, production**).
- Help scale **specialized workloads** beyond a single subscription’s limits.
- Support **cost tracking** per organizational unit.

### **Best Practices for Subscriptions**
- Group subscriptions under **management groups** for policy inheritance.
- Use **shared services subscriptions** for common resources like networking.
- Consider **subscription scale limits** for high-performance workloads.
- Separate subscriptions for **administrative control** (e.g., HR vs. Legal).
- Assign **Azure policies** at the subscription level for compliance needs.
- Ensure **networking topologies** allow cross-subscription communication.
- Perform **access reviews** to manage privileges effectively.

---

## Resource Groups
Resource groups are **logical containers** for Azure resources. They:
- Group resources **by type, application, department, or region**.
- Organize resources for **lifecycle management** (deploy/update/delete together).
- Allow **role-based access control (RBAC) and policy enforcement**.

### **Best Practices for Resource Groups**
- **Group by type**: Separate web services, databases, and VMs.
- **Group by app**: Keep all components of an app in a single resource group.
- **Group by department, region, or cost center**: Align with business structure.
- **Use a hybrid approach**: Mix different strategies as needed.
- **Control access**: Apply **Azure roles, policies, and resource locks**.
- **Ensure compliance**: Store metadata in specific regions for regulatory adherence.

## Azure Governance Summary

### Resource Tags

Resource tags provide metadata to Azure resources, aiding in organization, cost management, and automation. Before implementing tags, define objectives such as reporting, billing, and searchability.

#### Key Points:
- Tags consist of key-value pairs (e.g., `env=production`).
- Tags can be applied at the resource, resource group, or subscription level but are not inherited.
- Managed through Azure Portal, PowerShell, Azure CLI, ARM templates, and REST API.
- Align tags with business nomenclature for consistency.
- Use Azure Policy to enforce tagging conventions.

#### Tagging Strategies:
1. **IT-Aligned Tagging:** Tracks workloads and environments (e.g., `app=catalogsearch1`, `env=production`).
2. **Business-Aligned Tagging:** Focuses on cost accountability (e.g., `department=marketing`).

#### Tag Categories:
- **Functional:** Defines the workload purpose (`tier=web`, `env=staging`).
- **Classification:** Identifies compliance (`confidentiality=private`).
- **Accounting:** Associates with billing groups (`department=finance`).
- **Partnership:** Identifies resource stakeholders (`owner=jsmith`).
- **Purpose:** Defines business impact (`revenueimpact=high`).

### Azure Policy

Azure Policy enforces governance by ensuring resource compliance with organizational standards.

#### Key Features:
- Supports individual policies and policy initiatives.
- Policies are inherited down the hierarchy.
- Evaluates resources both in Azure and Arc-enabled environments.
- Highlights noncompliant resources and automates remediation.
- Integrates with Azure DevOps Pipelines.

#### Considerations:
- Use the **Azure Policy compliance dashboard** for monitoring.
- Understand policy evaluation triggers:
  - Resource changes (creation, deletion, modification).
  - Assignment or modification of a policy.
  - Regular compliance checks (every 24 hours).
- Handle noncompliant resources through denial, logging, modification, or automatic remediation.
- Use Azure Policy alongside Azure RBAC for full governance.

### Role-Based Access Control (RBAC)

Azure RBAC regulates user access to Azure resources using a role-based model.

#### Key Points:
- RBAC is an **allow model** granting access based on role assignments.
- Common scenarios:
  - Allowing a user to manage VMs but not networks.
  - Granting database admin access to SQL databases.
  - Assigning a group full control over a resource group.
- **Least privilege principle**: Assign only necessary permissions.
- **Use groups over individual user assignments** for easier management.

#### Role Assignments:
- Scope roles at the **highest necessary level** (Management Group > Subscription > Resource Group > Resource).
- Overlapping role assignments aggregate permissions.

#### Azure Policy vs. RBAC:
| Feature | Azure Policy | Azure RBAC |
|---------|------------|-----------|
| Focus | Resource state compliance | User access permissions |
| Implementation | Enforce rules | Assign roles |
| Default Access | Allowed unless denied by policy | Denied unless explicitly assigned |

#### Custom Roles:
- If built-in roles do not meet needs, define custom roles.
- Custom roles can be shared across trusted Microsoft Entra ID subscriptions.

By leveraging resource tags, Azure Policy, and RBAC effectively, organizations can enforce strong governance and compliance within their Azure environments.

