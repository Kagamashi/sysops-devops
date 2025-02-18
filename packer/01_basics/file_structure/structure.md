
## **File Structure**
Packer configurations are written in **HCL2 (HashiCorp Configuration Language)** or **JSON**.

### **HCL2 vs JSON Template Formats**
- **HCL2 (Recommended)**: More readable, supports conditionals, loops, and better integration with Terraform.
- **JSON**: Supported for legacy configurations but lacks advanced features.

### **Example HCL2 Template (Preferred Format)**
```hcl
packer {
  required_plugins {
    amazon = {
      version = "~> 1.0.0"
      source  = "github.com/hashicorp/amazon"
    }
  }
}

source "amazon-ebs" "example" {
  ami_name      = "my-custom-ami"
  instance_type = "t2.micro"
  region        = "us-east-1"
}

build {
  sources = ["source.amazon-ebs.example"]
}
```

### **Example JSON Template (Legacy Format)**
```json
{
  "builders": [
    {
      "type": "amazon-ebs",
      "region": "us-east-1",
      "instance_type": "t2.micro",
      "ami_name": "my-custom-ami"
    }
  ]
}
```

### **Understanding Packer Blocks**
| Block | Purpose |
|--------|---------|
| `packer` | Defines required plugins and configurations. |
| `source` | Specifies the **builder** used to create images. |
| `build` | Defines the steps to provision and generate the final image. |

### **Packer Plugin System**
- **Builders**: Create images for cloud providers (AWS, Azure, GCP, etc.).
- **Provisioners**: Execute scripts or install software inside the machine.
- **Post-Processors**: Modify, upload, or distribute images after creation.

---
