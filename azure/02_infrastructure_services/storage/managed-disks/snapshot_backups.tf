# Azure Snapshot Backups
# provide point-in-time copies of Azure Managed Disks, allowing quick restoring of data or creation of new disks

#   - instant point in time copy - no need to detach the disk
#   - stored in Azure Blob Storage for efficiency
#   - works for OS and Data disks
#   - fast distaster recovery - quickly recreate VMs from snapshots

# Types of Azure snapshots:
#   - Full Snapshot: captures the entire disk; good for first time backups, full disk restores
#   - Incremental Snapshot: stores only changed blocks; good for regular backups

resource "azurerm_managed_disk" "example" {
  name                 = "example-disk"
  location             = azurerm_resource_group.example.location
  resource_group_name  = azurerm_resource_group.example.name
  storage_account_type = "Premium_LRS"
  create_option        = "Empty"
  disk_size_gb         = 128
}

# FULL snapshot
resource "azurerm_snapshot" "example_full" {
  name                = "example-full-snapshot"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  create_option       = "Copy"
  source_uri          = azurerm_managed_disk.example.id
}

# INCREMENTAL snapshot
resource "azurerm_snapshot" "example_incremental" {
  name                = "example-incremental-snapshot"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  create_option       = "Incremental"
  source_uri          = azurerm_managed_disk.example.id
}

# restore new disk from a snapshot
resource "azurerm_managed_disk" "restored" {
  name                 = "restored-disk"
  location             = azurerm_resource_group.example.location
  resource_group_name  = azurerm_resource_group.example.name
  storage_account_type = "Premium_LRS"
  create_option        = "Copy"
  source_resource_id   = azurerm_snapshot.example_incremental.id
}

# list snapshots
# az snapshot list --resource-group rg-snapshots --output table

# create new disk from snapshot
# az disk create --resource-group rg-snapshots --name restored-disk --source example-incremental-snapshot

# attach restored disk to a vm
# az vm disk attach --resource-group rg-snapshots --vm-name myVM --name restored-disk
