## Public vs. Private Modules

### **Public Modules**
- Hosted in the [Terraform Registry](https://registry.terraform.io/).
- Can be searched and referenced directly in your configurations.

#### Example:
```hcl
module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"  # Module location in the registry
  version = "3.0.0"                         # Specific version of the module

  cidr                 = "10.0.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true
}
```

---
