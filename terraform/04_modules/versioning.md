
## Using Git with Terraform Modules
Tagging specific versions of modules and referencing them in Terraform configurations ensures consistency and predictability.

### Tagging a Release in Git:
```bash
git tag -a v1.0.0 -m "Initial release of VPC module"
git push origin v1.0.0
```

### Referencing a Module in Terraform:
```hcl
module "vpc" {
  source  = "git::https://github.com/myorg/terraform-modules.git//vpc?ref=v1.0.0"
}
```

---
