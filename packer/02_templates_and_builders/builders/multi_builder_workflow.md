
## **Multi-Builder Workflows**
Packer allows defining multiple **builders** in a single configuration file, enabling the simultaneous creation of images for multiple clouds and hypervisors.

### **Example: Building for Azure and AWS**
```hcl
source "azure-arm" "azure_image" {
  location             = "East US"
  managed_image_name   = "azure-packer-image"
}

source "amazon-ebs" "aws_image" {
  region               = "us-east-1"
  source_ami_filter {
    filters = {
      name                = "ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"
      virtualization-type = "hvm"
    }
    owners      = ["099720109477"]
    most_recent = true
  }
  ami_name = "aws-packer-image"
}

build {
  sources = ["source.azure-arm.azure_image", "source.amazon-ebs.aws_image"]
}
```

### **Best Practices for Multi-Builder Workflows**
- **Use variables** to standardize instance types, regions, and credentials.
- **Reuse provisioners** across different builders to maintain consistency.
- **Define post-processors** to upload images to shared repositories (e.g., Azure Compute Gallery, AWS AMI store).
- **Ensure networking and security groups** are correctly configured for each provider.

---
