# Service Endpoints helps to securely connect VNets with Azure services by extending VNet identity to them

# Service Endpoints can be used with:
#   Azure Storage (Microsoft.Storage)
#   Azure SQL Database (Microsoft.Sql)
#   Cosmos DB (Microsoft.AzureCosmosDB)
#   Azure Key Vault (Microsoft.KeyVault)
#   Azure Web Apps (Microsoft.Web)
#   Azure Event Hubs (Microsoft.EventHub)
#   Azure Service Bus (Microsoft.ServiceBus)

# Benefits:
#   * restricts public access allowing only trusted VNets
#   * reduced latency by keeping traffic inside Azure backbone
#   * unlike private endpoints, no additional charges

# Downsides:
#   * does not provide private IP (still uses public IP)
#   * only works within Azure (cannot be used from on-premise or VPN)

resource "azurerm_subnet" "example_subnet" {
  name                 = "example-subnet"
  virtual_network_name = azurerm_virtual_network.example_vnet.name
  resource_group_name  = azurerm_resource_group.example.name
  address_prefixes     = ["10.0.1.0/24"]

  service_endpoints = [ #  # https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet#service_endpoints-1:~:text=Link%20Services.-,service_endpoints,-%2D%20(Optional)%20The%20list
    "Microsoft.Storage",
    "Microsoft.Sql"
  ]
}
