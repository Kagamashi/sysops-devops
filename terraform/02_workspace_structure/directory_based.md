
## **Directory-Based Approach**
A common pattern for managing multiple environments is using separate directories for each environment.

### **Directory Structure Example:**
```
project-root/
├── envs/
│   ├── dev/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   ├── backend.tf
│   │   ├── terraform.tfvars
│   ├── staging/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   ├── backend.tf
│   │   ├── terraform.tfvars
│   ├── prod/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   ├── backend.tf
│   │   ├── terraform.tfvars
```

### **Pros:**
✅ Completely isolated state per environment.
✅ Allows different Terraform versions, providers, and configurations per environment.
✅ Easier integration with **remote state storage** (e.g., S3, Azure Blob, etc.).
✅ Simplifies **RBAC and security** by restricting access to individual environment directories.

### **Cons:**
❌ **Code duplication** across environments.
❌ Harder to maintain and update common configurations across multiple environments.
❌ Requires managing separate backend configurations per environment.

### **Code Reuse Strategies for Directory-Based Approach:**
- Use **Terraform modules** to share common configurations.
- Store **backend configuration** separately but reference a common remote backend.
- Example of using modules:
  ```hcl
  module "network" {
    source = "../modules/network"
    env    = "dev"
  }
  ```

---
