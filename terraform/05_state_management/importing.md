## Importing Resources into State
The `terraform import` command allows you to bring existing infrastructure under Terraform management by associating resources with state files.

### Key Points:
- **State updates only:** `terraform import` does not update `.tf` files; only the state file is updated.
- **Manual configuration:** After importing, update the `.tf` files manually to match the imported resource.

### Example:
```bash
terraform import aws_instance.example i-1234567890abcdef0
```

---
