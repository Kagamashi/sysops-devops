# Point-to-Site (P2S) VPN
# remote access, WFH, mobile users

# - allows individual clients to connect to Azure
# - remote workers, developers, mobile devices
# - on-demand connection for individual users
# - uses SSTP, OpenVPN, IPsec/IKEv2
# - limited to 500 Mbps per tunnel
# - requires VPN client installation

# Azure VPN Gateway is a managed Azure service that enables encrypted communication between on-prem and Azure VNets over the public internet using IPsec/IKE (Internet Key Exchange) VPN tunnels
#   - cost effective compared to ExpressRoute
#   - supports multi-region hybrid connectivity
#   - uses IPsec for encryption
#   - works over the public internet

# Supported protocols:
#   - OpenVPN - strong security, cross-platform, recommended for most users
#   - SSTP (Secure Socket Tunneling Protocol) - Windows-only
#   - IKEv2 VPN - fast, stable, supports macOS, Windows, Linux

resource "azurerm_virtual_network_gateway" "p2s" {
  name                = "example-p2s-vpn-gateway"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  type                = "Vpn"
  vpn_type            = "RouteBased"
  sku                 = "VpnGw2"

  ip_configuration {
    name                          = "gateway-ipconfig"
    subnet_id                     = azurerm_subnet.gateway_subnet.id
    public_ip_address_id          = azurerm_public_ip.vpn_gateway_ip.id
  }

  vpn_client_configuration {
    address_space = ["172.16.2.0/24"]  # IP range assigned to VPN clients
    vpn_auth_types = ["Certificate"]
  }
}
