# Fully managed stateful firewall.
# Provides threat intelligence and supports FQDN-based rules.

# Azure Firewall Standard - basic security and cost-efficiency: FQDN filtering, NAT, network rules
# Azure Firewall Premium - advanced threat protection: TLS decryption, deep packet inspection, IDPS, URL filtering

# Key features:
#   - Network Rules (layer 3 & 4) -  controls traffic based on IP addresses, ports, protocols (allow SSH froma  specific IP range only)
#   - Application Rules (layer 7) - filters traffic based on FQDNs (alllow only "*.microsoft.com" and block social media sites)
#   - NAT Rules (Network Address Translation) - used for public-facing apps (translate public IP to private IP for backend server)
#   - Threat Intelligence - block malicious IPs & domains (automatically block traffic from known botnets)
#   - Intrustion Detection & Prevention System (IDPS) - detect and prevents malicious activities using deep packet inspection
#   - TLS Inspection - descrypts and inspects encrypted HTTPS traffic (Premium SKU)
#   - DNS Proxy & FQDN Filtering - enforce domain-level filtering


resource "azurerm_subnet" "firewall_subnet" {
  name                 = "AzureFirewallSubnet"  # must be named exactly like this
  virtual_network_name = azurerm_virtual_network.firewall_vnet.name
  resource_group_name  = azurerm_resource_group.example.name
  address_prefixes     = ["10.0.0.0/24"]
}

resource "azurerm_public_ip" "example" {
  name                = "testpip"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  allocation_method   = "Static"
  sku                 = "Standard"
}

resource "azurerm_firewall" "example" {
  name                = "testfirewall"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  sku_name            = "AZFW_VNet" # "AZFW_VNet" (Standard) || "AZFW_Hub" (Premium)
  sku_tier            = "Standard"

  ip_configuration {
    name                 = "configuration"
    subnet_id            = azurerm_subnet.example.id
    public_ip_address_id = azurerm_public_ip.example.id
  }
}

# layer 3 & 4
resource "azurerm_firewall_network_rule_collection" "example" {
  name                = "testcollection"
  azure_firewall_name = azurerm_firewall.example.name
  resource_group_name = azurerm_resource_group.example.name
  priority            = 100
  action              = "Allow"

  rule {
    name = "testrule"

    source_addresses = [ # allow outbound traffic from 10.0.0.0/16 (our VNET)
      "10.0.0.0/16",
    ]

    destination_ports = [
      "53",
    ]

    destination_addresses = [ # to external DNS servers (Google DNS)
      "8.8.8.8",
      "8.8.4.4",
    ]

    protocols = [
      "TCP",
      "UDP",
    ]
  }
}

# layer 7
resource "azurerm_firewall_application_rule_collection" "example" {
  name                = "testcollection"
  azure_firewall_name = azurerm_firewall.example.name
  resource_group_name = azurerm_resource_group.example.name
  priority            = 100
  action              = "Allow"

  rule {
    name = "testrule"

    source_addresses = [ # allow outbound traffic from 10.0.0.0/16 (our VNET)
      "10.0.0.0/16",
    ]

    target_fqdns = [ # to any subdomain under "*.google.com"
      "*.google.com",
    ]

    protocol {
      port = "443"
      type = "Https"
    }
  }
}
