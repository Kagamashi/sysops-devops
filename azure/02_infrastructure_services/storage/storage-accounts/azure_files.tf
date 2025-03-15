# Azure Files
# fully managed file shares in the cloud, accessible via SMB (Windows), NFS (Linux), or HTTP protocols

# Key characteristics:
# • serverless (PaaS): no need to manage infrastracture
# • almost unlimited storage: up to 100TiB per share, individual files up to 4TiB
# • data encrypted at rest and in transit (HTTPS/SMB 3.0+)
# • clients can mount from Windows, Linux, macOS
# • Microsoft Entra integration
# • snapshots and Azure Backup:
#   - incremental snapshot: stores only changes, can restore individual files
#   - soft delete for 1-365 days
# • data redundancy:
#   - LRS (Locally Redundant Storage): 3 copies within a single data center
#   - ZRS (Zone Redundant Storage): 3 copie across different Availability Zones
#   - GRS (Geo Redundant Storage): 6 copies (3 in primary region, 3 in secondary region)
#   - GZRS (Geo Zone Redundant Storage): combines ZRS + GRS for best resillience

# Authentication methods:
#   • Identity-based (SMB): seamless SSO with AD DS identities
#   • Access Key: full access to entire storage account (older, less secure)
#   • SAS Token: restricted access for REST API calls

# Use cases:
#   • replace on-prem file servers with cloud-based
#   • global file sharing across multiple OS and locations
#   • lift-and-shift applications that expect a file system
#   • Azure File Sync for on-prem caching and branch office scenarios

# Azure File Sync:
#   • caches Azure Files shares on Windows Server/cloud VM
#   • supports SMB, NFS, FTPS for local access
#   • cloud tiering: rarely used files are kept in Azure; frequently accessed files remain local
#   • great for branch offices, DR (via Azure Backup), app lift-and-shift

# Azure Storage Explorer:
#    • cross-platform GUI for managing Azure Storage
#    • supports connecting via Azure subs, SAS tokens, access keys
#    • manage files, snapshots, directories


resource "azurerm_storage_account" "example" {
  name                     = "azureteststorage"
  resource_group_name      = azurerm_resource_group.example.name
  location                 = azurerm_resource_group.example.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_storage_share" "example" {
  name               = "sharename"
  storage_account_id = azurerm_storage_account.example.id
  quota              = 50

  acl {
    id = "MTIzNDU2Nzg5MDEyMzQ1Njc4OTAxMjM0NTY3ODkwMTI"

    access_policy {
      permissions = "rwdl"
      start       = "2019-07-02T09:38:21Z"
      expiry      = "2019-07-02T10:38:21Z"
    }
  }
}

resource "azurerm_private_endpoint" "example" {
  name                = "files-private-endpoint"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  subnet_id           = azurerm_subnet.example.id

  private_service_connection {
    name                           = "privatelink-files"
    private_connection_resource_id = azurerm_storage_account.example.id
    subresource_names              = ["file"]  # private endpoint for Azure Files
    is_manual_connection           = false
  }
}

# Mount on Windows (SMB):
# $storageAccountKey = "<STORAGE_ACCOUNT_KEY>"
# $storageAccountName = "storagefilesexample"
# $shareName = "file-share"
# net use Z: \\$storageAccountName.file.core.windows.net\$shareName /u:$storageAccountName $storageAccountKey

# Mount on Linux (SMB):
# sudo mkdir /mnt/azurefiles
# sudo mount -t cifs //storagefilesexample.file.core.windows.net/file-share /mnt/azurefiles \
#   -o vers=3.0,username=storagefilesexample,password=<STORAGE_ACCOUNT_KEY>,dir_mode=0777,file_mode=0777
