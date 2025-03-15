# Azure DNS Resolver

# Azure default DNS cannot forward queries outside Azure. DNS Resolver acts as a bridge for custom DNS resolutions. 

# Fully managed DNS forwarding service that allows:
#   - custom DNS resolution for on-premises and hybrid environments
#   - forwarding of DNS queries to external DNS servers
#   - integration with Private Endpoints and Private Links

resource "azurerm_subnet" "example" {
  name                 = "dns_subnet"
  virtual_network_name = azurerm_virtual_network.example.name
  resource_group_name = azurerm_resource_group.example.name
  address_prefixes     = ["10.0.0.1/24"]

  delegation {
    name = "Microsoft.Network.dnsResolvers" # delegation for DNS resolver

    service_delegation {
      name    = "Microsoft.Network/dnsResolvers"
      actions = ["Microsoft.Network/virtualNetworks/subnets/join/action"]
    }
  }
}

resource "azurerm_private_dns_resolver" "example" {
  name                = "example-resolver"
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location
  virtual_network_id  = azurerm_virtual_network.example.id
}

# outbound endpoint allows forwarding DNS queries to external servers, like on-prem DNS
resource "azurerm_private_dns_resolver_outbound_endpoint" "example" {
  name                    = "example-endpoint"
  private_dns_resolver_id = azurerm_private_dns_resolver.example.id
  location                = azurerm_private_dns_resolver.example.location
  subnet_id               = azurerm_subnet.example.id # must be dedicated subnet
}

# rulesets control DNS forwarding behavior, allowing selective forwarding
resource "azurerm_private_dns_resolver_dns_forwarding_ruleset" "example" {
  name                                       = "example-drdfr"
  resource_group_name                        = azurerm_resource_group.example.name
  location                                   = azurerm_resource_group.example.location
  private_dns_resolver_outbound_endpoint_ids = [azurerm_private_dns_resolver_outbound_endpoint.example.id]
}

# creates forwarding rule to send onprem.local queries to 10.10.0.1
resource "azurerm_private_dns_resolver_forwarding_rule" "example" {
  name                      = "example-rule"
  dns_forwarding_ruleset_id = azurerm_private_dns_resolver_dns_forwarding_ruleset.example.id
  domain_name               = "onprem.local."
  enabled                   = true

  target_dns_servers {
    ip_address = "10.10.0.1"
    port       = 53 # standard DNS port
  }
}
