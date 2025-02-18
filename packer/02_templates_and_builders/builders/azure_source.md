# Packer Azure Builder: Creating Custom Machine Images

## **Introduction to Packer with Azure**
Packer provides **automated image building** for **Azure Virtual Machines** using the `azure-arm` builder. This allows DevOps teams to **create and maintain custom VM images** that can be used across multiple deployments.

### **Key Benefits:**
- Automates VM image creation for **Azure environments**.
- Ensures consistency across deployments.
- Supports authentication using **Service Principals**.
- Works with **both managed and unmanaged disks**.

---

## **Authenticating Packer with Azure**
Packer requires **Azure authentication** via a **Service Principal** to interact with the Azure API.

### **Step 1: Create a Service Principal**
```sh
az ad sp create-for-rbac --role Contributor --scopes /subscriptions/<SUBSCRIPTION_ID>
```
This command outputs:
```json
{
  "appId": "<CLIENT_ID>",
  "displayName": "packer-service-principal",
  "password": "<CLIENT_SECRET>",
  "tenant": "<TENANT_ID>"
}
```

### **Step 2: Set Environment Variables for Authentication**
```sh
export ARM_CLIENT_ID="<CLIENT_ID>"
export ARM_CLIENT_SECRET="<CLIENT_SECRET>"
export ARM_TENANT_ID="<TENANT_ID>"
export ARM_SUBSCRIPTION_ID="<SUBSCRIPTION_ID>"
```

---

## **Packer HCL Template for Azure**
Below is an **example Packer template** for building an Ubuntu 20.04 image in Azure.

```hcl
packer {
  required_plugins {
    azure = {
      version = "~> 1.0.0"
      source  = "github.com/hashicorp/azure"
    }
  }
}

source "azure-arm" "ubuntu_image" {
  client_id       = "${env("ARM_CLIENT_ID")}"
  client_secret   = "${env("ARM_CLIENT_SECRET")}"
  tenant_id       = "${env("ARM_TENANT_ID")}"
  subscription_id = "${env("ARM_SUBSCRIPTION_ID")}"
  
  resource_group_name          = "packer-rg"
  storage_account              = "packerstorage"
  location                     = "East US"
  managed_image_name           = "packer-image"
  managed_image_resource_group_name = "packer-rg"
  os_type                      = "Linux"
  image_publisher              = "Canonical"
  image_offer                  = "UbuntuServer"
  image_sku                    = "20.04-LTS"
}

build {
  sources = ["source.azure-arm.ubuntu_image"]
}
```

---
