# Private Endpoint 

# Allows secure connection to Azure PaaS services over a private IP address, avoiding exposure to the public internet

# PaaS Service
resource "azurerm_storage_account" "example" {
  name                     = "examplesa"
  resource_group_name      = azurerm_resource_group.example.name
  location                 = azurerm_resource_group.example.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

# subresource_names:
#   "blob" SA
#   "namespace" EH NS
#   ...
# https://learn.microsoft.com/en-us/azure/private-link/private-endpoint-overview#private-link-resource
resource "azurerm_private_endpoint" "example" {
  name                = "example-endpoint"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  subnet_id           = azurerm_subnet.example.id

  private_service_connection {
    name                           = "example-privateserviceconnection"
    private_connection_resource_id = azurerm_storage_account.example.id
    subresource_names              = ["blob"]
    is_manual_connection           = false
  }

  private_dns_zone_group {
    name                 = "example-dns-zone-group" # linking DNS zone to PE creates A record (stops resolving to public endpoint)
    private_dns_zone_ids = [azurerm_private_dns_zone.example.id] # examplesa.privatelink.blob.core.windows.net → 10.0.1.5
  }
}

# private_dns_zone.name:
#   "privatelink.azurecr.io"  ACR
#   "privatelink.blob.core.windows.net" SA
#   "privatelink.postgres.database.azure.com" PSQL
#   "privatelink.vaultcore.azure.net" KV
#   ...
# https://learn.microsoft.com/en-us/azure/private-link/private-endpoint-dns#virtual-network-and-on-premises-workloads-using-a-dns-forwarder 
resource "azurerm_private_dns_zone" "example" {
  name                = "privatelink.blob.core.windows.net"
  resource_group_name = azurerm_resource_group.example.name
}

resource "azurerm_private_dns_zone_virtual_network_link" "example" {
  name                  = "example-link"
  resource_group_name   = azurerm_resource_group.example.name
  private_dns_zone_name = azurerm_private_dns_zone.example.name
  virtual_network_id    = azurerm_virtual_network.example.id
}
