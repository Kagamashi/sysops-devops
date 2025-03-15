# Azure Virtual WAN
# Centralized hub-and-spoke architecture for connecting branch offices and on-premises networks
# Integrates VPN, ExpressRoute and Azure Firewall for global connectivity

# Virtual WAN components:
#   Virtual WAN	            global networking service that orchestrates connectivity
#   Virtual Hub             regional network hub that connects VNets, VPNs, and ExpressRoute
#   VPN Gateway	            enables Site-to-Site (S2S) and Point-to-Site (P2S) VPN connections
#   ExpressRoute Gateway	  connects on-premises networks to Azure via ExpressRoute
#   Azure Firewall	        adds security and traffic filtering to VWAN
#   Network Security Rules  controls traffic flow between connected VNets, VPNs, and ExpressRoute

# Virtual WAN -> globally scalable, cloud-managed network
# Hub-and-Spoke -> full control over network traffic routing

resource "azurerm_virtual_wan" "example" {
  name                = "example-vwan"
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location
  allow_branch_to_branch_traffic = true
  type = "Standard"  # Basic || Standard
}

# acts as central network router
resource "azurerm_virtual_hub" "example" {
  name                = "example-vhub"
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location
  virtual_wan_id      = azurerm_virtual_wan.example.id # virtual WAN
  address_prefix      = "10.0.0.0/24"
}

# defines VPN gateway enabling S2S and P2S VPN connections
resource "azurerm_vpn_gateway" "example" {
  name                = "example-vpn-gateway"
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location
  virtual_hub_id      = azurerm_virtual_hub.example.id

  scale_unit = 1
}

# connect VNets to Virtual WAN
resource "azurerm_virtual_hub_connection" "example" {
  name                   = "example-vnet-connection"
  virtual_hub_id         = azurerm_virtual_hub.example.id
  remote_virtual_network_id = azurerm_virtual_network.example.id
}