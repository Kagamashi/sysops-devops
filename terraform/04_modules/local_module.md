### **Local Modules**
- Located within the project directory and referenced using relative paths.

#### Example:
```hcl
module "vpc" {
  source = "./modules/vpc"  # Relative path to the local module

  cidr_block = "10.0.0.0/16"
}
```

---
