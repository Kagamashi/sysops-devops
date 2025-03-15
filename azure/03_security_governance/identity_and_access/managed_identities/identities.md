# Types of Identities in Azure

Azure supports multiple identity types, each serving a different purpose.

| **Identity Type**      | **Description**                                                 | **Best Use Case**                                                |
|-----------------------|-------------------------------------------------------------|----------------------------------------------------------------|
| **User Identity**      | Represents real people in Azure AD.                         | Individual access for employees, admins, and developers.     |
| **Service Principal (SPN)** | Application identity used by apps, services, or automation scripts. | Grant limited permissions to apps or scripts instead of using a user account. |
| **Managed Identity (MSI)**  | Auto-managed identity assigned to Azure resources (VMs, Functions, AKS). | Secure VMs, Functions, AKS pods without storing secrets. |
| **Guest User (B2B)**   | External users invited via Azure B2B collaboration.        | Allow partners, vendors, or contractors access to resources. |
| **Workload Identity**  | Special OIDC identity for workloads like containers or serverless services. | Used for Kubernetes (AKS), workloads needing OAuth 2.0 authentication. |
| **Federated Identity** | Identity that uses external IdPs (Okta, Google, AD FS, GitHub, etc.). | Single Sign-On (SSO) & external authentication providers. |

---

## User Identities
🔹 Represent real users in **Azure Active Directory (Azure AD)**.
🔹 Can authenticate via **passwords, MFA, FIDO2 security keys**.
🔹 Assigned **roles & permissions** using **RBAC** or **PIM**.

**Example:**
- Alice is an Azure Admin → Assigned **Owner** role in the Subscription.
- Bob is a Developer → Assigned **Contributor** role in the Resource Group.

---

## Service Principal (SPN)
🔹 **Non-human identity** for applications, automation scripts, and services.
🔹 Used in **CI/CD pipelines, Terraform, and API authentication**.
🔹 Has **least-privilege access** with RBAC.

**Example:**
- Terraform Deployment: Uses **Service Principal** to provision resources in Azure.
- GitHub Actions: Uses **SPN credentials** to deploy infrastructure.

🔹 **Create a Service Principal via CLI**:
```sh
az ad sp create-for-rbac --name "my-spn" --role "Contributor"
```
**Best Practice:** Use **Managed Identity** instead of SPN when possible.

---

## Managed Identity (MSI)
🔹 **Automatically managed** identity assigned to Azure resources.
🔹 No need to store **credentials, secrets, or certificates**.
🔹 Works with **Key Vault, Storage Accounts, SQL, and other Azure services**.

**Example:**
- A VM needs to access a **Storage Account**. Instead of storing access keys, it uses a **Managed Identity**.

### **Types of Managed Identities**
| **Type**             | **Description**                                 |
|----------------------|---------------------------------------------|
| **System-Assigned**  | Created per resource (e.g., VM, Function App). Deleted when the resource is deleted. |
| **User-Assigned**    | A standalone identity shared across multiple resources. |

**Assign Managed Identity to a VM via Terraform**:
```hcl
resource "azurerm_virtual_machine" "example" {
  name                  = "example-vm"
  location              = azurerm_resource_group.example.location
  resource_group_name   = azurerm_resource_group.example.name
  vm_size               = "Standard_D2s_v3"

  identity {
    type = "SystemAssigned"
  }
}
```
**Best Practice:** Use **Managed Identity** instead of storing service credentials.

---

## 4Guest Users (B2B)
🔹 **External users** (partners, vendors, clients) invited via **Azure AD B2B**.
🔹 They authenticate using **their own identity provider** (Google, Okta, Facebook, etc.).
🔹 Can be **assigned roles** just like internal users.

**Example:**
- Invite an **external consultant** to collaborate in an **Azure subscription**.
- They sign in using their **company’s Google or Okta credentials**.

🔹 **Invite a Guest User via CLI**:
```sh
az ad user invite --user-principal-name "externaluser@gmail.com" --role "Reader"
```
**Best Practice:** Restrict guest access using **Conditional Access policies**.

---

## 5Workload Identity
🔹 **OIDC-based identity** for workloads running in **Kubernetes (AKS), containers, or serverless**.
🔹 More secure than **Managed Identities** for federated authentication.
🔹 Uses **OAuth 2.0** instead of storing client secrets.

**Example:**
- A **Kubernetes pod** authenticates with **Azure Key Vault** using a **Workload Identity**.
- **No need to create a Service Principal or store credentials**.

**Best Practice:** Use **Workload Identity** for **AKS & containerized applications** instead of **Service Principal**.

---

## Federated Identity
🔹 Allows authentication via **external providers** (Google, AD FS, GitHub, Okta, etc.).
🔹 Supports **Single Sign-On (SSO) & OAuth 2.0 authentication**.
🔹 Common in **hybrid environments & multi-cloud setups**.

**Example:**
- A **developer logs into Azure using their GitHub account** (Federated Identity).
- A **hybrid setup allows users to authenticate using on-prem AD FS** (Federated Identity Provider).
