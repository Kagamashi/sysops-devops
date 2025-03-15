# Azure ExpressRoute
# recommended for mission-critical workloads, hybrid cloud

# ExpressRoute is an edicated, private network connection between on-premises infrastructure and Azure
# offers higher security, reiability, and lower latency compared to traditional VPNs

# Key features:
#   - bypasses the public internet, reducing latency and increasing security
#   - provides speeds from 50Mbps to 100Gbps
#   - supports multi-region connectivity using ExpressRoute Global Reach
#   - offers SLA-backed reliability (99.95% uptime guarantee)
#   - allows connectivity to Microsoft cloud services: Azure, Microsoft 365, Dynamics 365

# How it works:
#   1️. You connect your on-premises network to Azure via an ExpressRoute partner (e.g., Equinix, AT&T, Verizon).
#   2️. Microsoft assigns a private circuit with a unique service key.
#   3️. BGP (Border Gateway Protocol) establishes connectivity between on-prem and Azure.
#   4️. Traffic flows privately between Azure and on-premises (without using the public internet).

# Connectivity models:
#   Cloud Exchange Co-location: connect via Exchange Provider (eq. Equinix, Megaport)
#   Point-to-Point (P2P): dedicated fiber link between on-prem and Azure
#   Any-to-Any (IPVPN): uses an MPLS VPN for global enterprise connectivity
#   Directly from ExpressRoute sites

# ExpressRoute components:
#   ExpressRoute Circuit: dedicated connection between Azure and on-prem
#   ExpressRoute Gateway: required to connect a VNet to ExpressRoute
#   Perring Types: Microsoft Peering (365, Azure PaaS) and Private Peering
#   Global Reach: enables communication between different on-premises sistes through Azure


# GatewaySubnet is required for Virtual Network Gateway
resource "azurerm_subnet" "gateway_subnet" {
  name                 = "GatewaySubnet"
  resource_group_name  = azurerm_resource_group.example.name
  virtual_network_name = azurerm_virtual_network.example.name
  address_prefixes     = ["10.1.1.0/24"]
}

# VNet Gateway is needed to connect Azure VNet with ExpressRoute
resource "azurerm_virtual_network_gateway" "example" {
  name                = "example-er-gateway"
  resource_group_name  = azurerm_resource_group.example.name
  location             = azurerm_resource_group.example.location
  type                = "ExpressRoute" # ExpressRoute || Vpn
  vpn_type            = "RouteBased"
  active_active       = false
  enable_bgp          = true
  sku                 = "Standard"  # HighPerformance || UltraPerformance

  ip_configuration {
    name                          = "gateway-ipconfig"
    subnet_id                     = azurerm_subnet.gateway_subnet.id
    public_ip_address_id           = azurerm_public_ip.example.id
  }
}

resource "azurerm_express_route_circuit" "example" {
  name                  = "example-expressroute"
  resource_group_name   = azurerm_resource_group.example.name
  location              = azurerm_resource_group.example.location
  service_provider_name = "Equinix"         # ExpressRoute provider
  peering_location      = "Silicon Valley"  # physical peering location
  bandwidth_in_mbps     = 1000  # 1 Gbps ExpressRoute circuit
  
  sku {
    tier   = "Standard"     # Standard || Premiume (global reach)
    family = "MeteredData"  # UnlimitedData || MeteredData
  }

  allow_classic_operations = false
}

resource "azurerm_express_route_circuit_peering" "example" {
  peering_type                  = "MicrosoftPeering"
  express_route_circuit_name    = azurerm_express_route_circuit.example.name
  resource_group_name           = azurerm_resource_group.example.name
  peer_asn                      = 100
  primary_peer_address_prefix   = "123.0.0.0/30"
  secondary_peer_address_prefix = "123.0.0.4/30"
  ipv4_enabled                  = true
  vlan_id                       = 300

  microsoft_peering_config {
    advertised_public_prefixes = ["123.1.0.0/24"]
  }

  ipv6 {
    primary_peer_address_prefix   = "2002:db01::/126"
    secondary_peer_address_prefix = "2003:db01::/126"
    enabled                       = true

    microsoft_peering {
      advertised_public_prefixes = ["2002:db01::/126"]
    }
  }
}
