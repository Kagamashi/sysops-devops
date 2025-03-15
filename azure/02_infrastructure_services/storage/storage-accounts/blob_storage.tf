# BLOB STORAGE
# - each blob must exist inside a container
# - each containers can contain unlimited blobs
# - each storage account can contain unlimited containers

# Use cases:
#   - browser uploads (images/documents)
#   - distributed access (files for installation/shared usage)
#   - streaming (video/audio content)
#   - backups, restore
#   - data analysis

# Storage access tiers:
#   - HOT: ms latency (0+ days)
#   - COOL: ms latency (30+ days)
#   - COLD: ms latency (90+ days)
#   - ARCHIVE: hours latency (180+ days)
# Use Lifecycle Management Policies to automatically move data to a cheaper tier

# Blob types:
#   - Block blobs: store text/binary data
#   - Append blobs: logging (eg logging)
#   - Page blobs: frequent read/write (eg Azure VM disks), max 8TB
# Cannot be changed after creation

# Uploading blobs:
#   - Azure Storage Explorer: graphical UI
#   - AzCopy: CLI tool
#   - Data Box Disk: physical disks for large on-prem data transfers
#   - Import/Export: ship disks to Azure datacenter


resource "azurerm_storage_container" "example" {
  name                  = "content"
  storage_account_name  = azurerm_storage_account.example.name
  container_access_type = "private"
}

resource "azurerm_storage_blob" "example" {
  name                   = "my-awesome-content.zip"
  storage_account_name   = azurerm_storage_account.example.name
  storage_container_name = azurerm_storage_container.example.name
  type                   = "Block"
  source                 = "some-local-file.zip"
}

# management_policies
resource "azurerm_storage_management_policy" "example" {
  storage_account_id = azurerm_storage_account.example.id

  rule {
    name    = "rule1"
    enabled = true
    filters {
      prefix_match = ["container1/prefix1"]
      blob_types   = ["blockBlob"]
      match_blob_index_tag {
        name      = "tag1"
        operation = "=="
        value     = "val1"
      }
    }
    actions {
      base_blob {
        tier_to_cool_after_days_since_modification_greater_than    = 10
        tier_to_archive_after_days_since_modification_greater_than = 50
        delete_after_days_since_modification_greater_than          = 100
      }
      snapshot {
        delete_after_days_since_creation_greater_than = 30
      }
    }
  }
  rule {
    name    = "rule2"
    enabled = false
    filters {
      prefix_match = ["container2/prefix1", "container2/prefix2"]
      blob_types   = ["blockBlob"]
    }
    actions {
      base_blob {
        tier_to_cool_after_days_since_modification_greater_than    = 11
        tier_to_archive_after_days_since_modification_greater_than = 51
        delete_after_days_since_modification_greater_than          = 101
      }
      snapshot {
        change_tier_to_archive_after_days_since_creation = 90
        change_tier_to_cool_after_days_since_creation    = 23
        delete_after_days_since_creation_greater_than    = 31
      }
      version {
        change_tier_to_archive_after_days_since_creation = 9
        change_tier_to_cool_after_days_since_creation    = 90
        delete_after_days_since_creation                 = 3
      }
    }
  }
}
