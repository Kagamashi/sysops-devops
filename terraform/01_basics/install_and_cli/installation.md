# Terraform Installation and CLI Basics

## Installation
Terraform can be downloaded from the official HashiCorp website:
[Terraform Downloads](https://developer.hashicorp.com/terraform/downloads)

### **Installation Steps:**
1. **Windows**:
   - Download the `.zip` file from the website.
   - Extract it and place the `terraform.exe` file in a directory included in your system `PATH`.

2. **Linux/macOS**:
   ```bash
   curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -
   sudo apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main"
   sudo apt-get update && sudo apt-get install terraform
   ```
   - Alternatively, use Homebrew on macOS:
     ```bash
     brew tap hashicorp/tap
     brew install hashicorp/tap/terraform
     ```

### **Verify Installation**
```bash
terraform -v
```

---
