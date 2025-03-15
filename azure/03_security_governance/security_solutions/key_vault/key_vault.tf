# Azure Key Vault
# secure cloud service for storing, managing, and accessing secrets, encryption keys and certificates

#   - store passwords, API keys, connection strings, certificates
#   - supports Hardware Security Modules (HPM) - protect keys with FIPS 140-2 Level 3 compliance
#   - automatic key rotation and expiry alerts
#   - soft delete & purge protection

# Types of objects in Key Vault:
#   - Secrets: passwords, connection strings, API keys
#   - Keys: encryption keys for Azure Disk Encryption, SQL TDE, Azure sTORAGE
#   - Certificates: store TLS/SSL certificates for apps, VMs, services

provider "azurerm" {
  features {
    key_vault {
      purge_soft_delete_on_destroy    = true
      recover_soft_deleted_key_vaults = true
    }
  }
}

resource "azurerm_key_vault" "example" {
  name                        = "examplekeyvault"
  location                    = azurerm_resource_group.example.location
  resource_group_name         = azurerm_resource_group.example.name
  enabled_for_disk_encryption = true
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  soft_delete_retention_days  = 7
  purge_protection_enabled    = false

  sku_name = "standard"

  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = data.azurerm_client_config.current.object_id

    key_permissions = [
      "Get",
    ]

    secret_permissions = [
      "Get",
    ]

    storage_permissions = [
      "Get",
    ]
  }
}
