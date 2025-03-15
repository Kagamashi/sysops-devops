
## **Drift Detection**
Terraform **drift** occurs when infrastructure is modified outside of Terraform (e.g., manual changes in the cloud console).

### **Detecting Drift**
✅ Run **`terraform plan`** to see if infrastructure has changed.
✅ Use **Terraform Cloud or CI/CD pipelines** for automatic drift detection.
✅ Avoid manual modifications to infrastructure when using Terraform.

#### **Example of Drift Detection Command:**
```bash
terraform plan
```
- Terraform will show differences between the current infrastructure and the `.tfstate` file.

---
