### **Private Modules**
- Stored in version control repositories like GitHub, GitLab, or Bitbucket.
- Referenced using the `source` attribute pointing to the repository URL.

#### Example:
```hcl
module "vpc" {
  source = "git::https://github.com/myorg/terraform-aws-vpc.git?ref=v1.0.0"  # Points to a specific version

  cidr_block = "10.0.0.0/16"
}
```

---
