# Site-to-Site (S2S) VPN
# recommended for businesses, hybrid cloud, branch connectivity

# - connects an entire on-premises network to Azure
# - enterprises connecting data centers, branch offices
# - permanent connection betwee networks
# - uses IPsec/IKE VPN for encryption
# - supports up to 10Gbps (depends on SKU)
# - configured on a VPN router/firewall

# Azure VPN Gateway is a managed Azure service that enables encrypted communication between on-prem and Azure VNets over the public internet using IPsec/IKE (Internet Key Exchange) VPN tunnels
#   - cost effective compared to ExpressRoute
#   - supports multi-region hybrid connectivity
#   - uses IPsec for encryption
#   - works over the public internet

resource "azurerm_subnet" "gateway_subnet" {
  name                 = "GatewaySubnet"
  virtual_network_name = azurerm_virtual_network.example.name
  resource_group_name  = azurerm_resource_group.example.name
  address_prefixes     = ["10.1.1.0/24"]
}

resource "azurerm_public_ip" "vpn_gateway_ip" {
  name                = "vpn-gateway-ip"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  allocation_method   = "Dynamic"
}

# VPN gateway
resource "azurerm_virtual_network_gateway" "example" {
  name                = "example-vpn-gateway"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  type                = "Vpn"
  vpn_type            = "RouteBased"  # || "PolicyBased"
  active_active       = false
  enable_bgp          = false
  sku                 = "VpnGw2"  # choose based on bandwidth requirements

  ip_configuration {
    name                          = "gateway-ipconfig"
    subnet_id                     = azurerm_subnet.gateway_subnet.id
    public_ip_address_id          = azurerm_public_ip.vpn_gateway_ip.id
  }
}

# represents ON-PREM
resource "azurerm_local_network_gateway" "on_prem" {
  name                = "onprem-local-gateway"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  gateway_address     = "203.0.113.10"      # on-prem public IP
  address_space       = ["192.168.1.0/24"]  # on-prem subnet
}

# connection Azure to On-Prem
resource "azurerm_virtual_network_gateway_connection" "vpn_connection" {
  name                       = "example-s2s-connection"
  location                   = azurerm_resource_group.example.location
  resource_group_name        = azurerm_resource_group.example.name
  type                       = "IPsec"
  virtual_network_gateway_id = azurerm_virtual_network_gateway.example.id
  local_network_gateway_id   = azurerm_local_network_gateway.on_prem.id
  shared_key                 = "SuperSecretSharedKey123!"  # Pre-Shared Key (PSK)
}
