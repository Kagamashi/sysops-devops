# AZURE VIRTUAL NETWORK

#   /16 for large VNets (65,536 IPs), /24 for subnets (256 IPs)(avoid /30 and /31)
#   avoid overlapping IP ranges
#   private IPs inside VNets, public IPs for internet connectivity (# Azure does not support public IP addresses inside a VNet for private communication)
#   Azure requires certain subnets for specific resources: GatewaySubnet, AzureBastionSubnet, AzureFirewallSubnet

# Azure VNets use private IPv4 addressing from the following RFC 1918 address spaces:
#   10.0.0.0/8 (10.0.0.0 – 10.255.255.255)
#   172.16.0.0/12 (172.16.0.0 – 172.31.255.255)
#   192.168.0.0/16 (192.168.0.0 – 192.168.255.255)

resource "azurerm_virtual_network" "vnet_hub" {
  name                = var.hub_vnet
  resource_group_name = azurerm_resource_group.rg_hub.name
  location            = "westeurope"
  address_space       = "10.0.0.0/16"
}

resource "azurerm_virtual_network" "vnet_p" {
  name                = "prod_vnet"
  resource_group_name = azurerm_resource_group.rg_p.name
  location            = "westeurope"
  address_space       = "10.2.0.0/16"
}

variable "hub_vnet" {
  type        = string
  default     = "hub_vnet"
  description = "The address prefix for the hub virtual network"

  validation {
    condition     = can(regex("^[0-9]+[.][0-9]+[.][0-9]+[.][0-9]+/[0-9]+$", var.hub_vnet))
    error_message = "invalid hub_vnet: validation failed"
  }
}
