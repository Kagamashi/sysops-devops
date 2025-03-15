
## **Locking and Concurrency Issues**
When using Terraform in a team, **simultaneous changes** can lead to state corruption.

### **How to Prevent Concurrency Issues?**
✅ **Use Remote Backends** – Most remote backends support locking mechanisms.
✅ **Enable State Locking** – Services like AWS DynamoDB or Terraform Cloud provide state locking.
✅ **Avoid Manual State Edits** – Modifying `.tfstate` manually can cause inconsistencies.

#### **Example: AWS S3 with State Locking**
```hcl
terraform {
  backend "s3" {
    bucket         = "my-terraform-state"
    key            = "prod/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-lock"
  }
}
```
- The **DynamoDB table** prevents multiple users from modifying the state at the same time.

---
