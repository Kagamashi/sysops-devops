# SUBNET segment virtual network into subnetworks

# Azure-Reserved Addresses: first four and last IPs in every subnet are reserved:
#   .0 → Network address
#   .1 → Azure Gateway
#   .2 → Azure DHCP
#   .3 → Future use
#   .255 → Broadcast
# eq. for subnet 10.0.1.0/24 the available IPs are 10.0.1.4 – 10.0.1.254 (251 usable IPs)


resource "azurerm_subnet" "example" {
  name                 = "prod_db"
  resource_group_name  = azurerm_resource_group.example.name
  virtual_network_name = azurerm_virtual_network.vnet_p.name
  address_prefixes     = "10.2.1.0/24"
  service_endpoints    = "Microsoft.Sql" # https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet#service_endpoints-1:~:text=Link%20Services.-,service_endpoints,-%2D%20(Optional)%20The%20list

  delegation {
    name = "delegation" # https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet#:~:text=A-,service_delegation,-block%20supports%20the

    service_delegation {
      name    = "Microsoft.ContainerInstance/containerGroups"
      actions = ["Microsoft.Network/virtualNetworks/subnets/join/action", "Microsoft.Network/virtualNetworks/subnets/prepareNetworkPolicies/action"]
    }
  }
}
