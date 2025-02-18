# Packer Installation and CLI Basics

## **1. Introduction to Packer**
Packer is a tool by **HashiCorp** that automates the creation of **machine images** for various platforms, including **AWS, Azure, GCP, VMware, and Docker**. It allows developers and DevOps teams to build consistent and repeatable infrastructure.

### **Key Features:**
- Automates the creation of **golden images**.
- Supports multiple platforms (AWS, Azure, VMware, etc.).
- Uses **declarative JSON or HCL templates**.
- Easily integrates with Terraform and CI/CD pipelines.

---

## **2. Installing Packer on Different Platforms**
Packer is available for **Windows, macOS, and Linux**.

### **macOS Installation (Using Homebrew)**
```sh
brew install packer
packer version
```

### **Linux Installation**
1. Download the latest Packer release:
   ```sh
   curl -LO https://releases.hashicorp.com/packer/latest/packer_linux_amd64.zip
   ```
2. Unzip and move the binary:
   ```sh
   unzip packer_linux_amd64.zip
   sudo mv packer /usr/local/bin/
   ```
3. Verify installation:
   ```sh
   packer version
   ```

---
