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
  vnet_name                    = ""
  subnet_name                  = ""
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
