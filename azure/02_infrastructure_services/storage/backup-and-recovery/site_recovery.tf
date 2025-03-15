# Azure Site Recovery
# disaster recovery solution that helps businesses replicate workloads from on-premises, Azure VMs to Azure or another region for failover and failback

#   - Disaster Recovery as a Service (DRaaS) - protects workloads from downtime and outages
#   - Cross-Region DR for Azure VMs - enables Azure-to-Azure VM replication
#   - On-Prem to Azure Replication - supports VMware, Hyper-V, Physical Servers
#   - automated recovery plans - define step-by-step DR procedures


# Recovery Services Vault (Stores DR Data)
resource "azurerm_recovery_services_vault" "example" {
  name                = "recovery-vault"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  sku                 = "Standard"
  soft_delete_enabled = true  # Protects against accidental deletion
}

# Site Recovery Fabric (Defines DR Infrastructure)
resource "azurerm_site_recovery_fabric" "example" {
  name                = "example-fabric"
  resource_group_name = azurerm_resource_group.example.name
  recovery_vault_name = azurerm_recovery_services_vault.example.name
  location            = azurerm_resource_group.example.location
}

# Protection Container (Holds Replicated VMs)
resource "azurerm_site_recovery_protection_container" "protection-container" {
  name                 = "protection-container"
  resource_group_name  = azurerm_resource_group.secondary.name
  recovery_vault_name  = azurerm_recovery_services_vault.vault.name
  recovery_fabric_name = azurerm_site_recovery_fabric.fabric.name
}

# Replication Policy (Retention & Failover Rules)
resource "azurerm_site_recovery_replication_policy" "example" {
  name                            = "example-replication-policy"
  resource_group_name             = azurerm_resource_group.example.name
  recovery_vault_name             = azurerm_recovery_services_vault.example.name
  recovery_point_retention_in_minutes = 1440                 # retain recovery points for 24 hours
  application_consistent_snapshot_frequency_in_minutes = 60  # capture application-consistent snapshots every hour
}

# Enable Protection for Azure VM
resource "azurerm_site_recovery_protected_vm" "example" {
  name                = "example-vm-replication"
  resource_group_name = azurerm_resource_group.example.name
  recovery_vault_name = azurerm_recovery_services_vault.example.name
  source_recovery_fabric_name = azurerm_site_recovery_fabric.example.name
  source_protection_container_name = azurerm_site_recovery_protection_container.example.name
  target_resource_group_id = azurerm_resource_group.example.id  # DR Target Resource Group
  source_vm_id = azurerm_virtual_machine.example.id             # Azure VM being protected
  recovery_replication_policy_id = azurerm_site_recovery_replication_policy.example.id
}

# trigger failover in Azure CLI
# az site-recovery failover-commit \
#   --resource-group rg-siterecovery \
#   --vault-name recovery-vault \
#   --fabric-name example-fabric \
#   --protection-container-name example-container \
#   --protected-item-name example-vm-replication

# test failover in Azure CLI
# az site-recovery failover-commit \
#   --resource-group rg-siterecovery \
#   --vault-name recovery-vault \
#   --fabric-name example-fabric \
#   --protection-container-name example-container \
#   --protected-item-name example-vm-replication
