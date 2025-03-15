# Control inbound and outbound traffic at subnet or NIC level.

# Applying NSG at subnet level (not NIC level) is easier to manage

# Service Tags:
#   Internet : all external traffic
#   VirtualNetwork : traffic within VNet
#   AzureLoadBalancer : traffic from Azure LB
#   Storage : traffic to Azure Storage

resource "azurerm_network_security_group" "example_nsg" {
  name                = "example-nsg"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
}

resource "azurerm_subnet_network_security_group_association" "example_assoc" {
  subnet_id                 = azurerm_subnet.example_subnet.id
  network_security_group_id = azurerm_network_security_group.example_nsg.id
}

variable "nsg_rules" {
  type = map(object({
    priority  = number
    direction = string
    access    = string
    protocol  = string
    source    = string
    source_port_range = string
    destination     = string
    destination_port_range = string
  }))

  default = {
    "allow_ssh" = {
      priority              = 100 # lower = higher priority
      direction             = "Inbound"
      access                = "Allow"
      protocol              = "Tcp" # TCP || UDP || ICMP || Any
      source                = "*"
      source_port_range     = "*"
      destination           = "*"
      destination_port_range = "22"
    }
    "allow_http" = {
      priority              = 200
      direction             = "Inbound"
      access                = "Allow"
      protocol              = "Tcp"
      source                = "*"
      source_port_range     = "*"
      destination           = "*"
      destination_port_range = "80"
    }
    "allow_https" = {
      priority              = 300
      direction             = "Inbound"
      access                = "Allow"
      protocol              = "Tcp"
      source                = "*"
      source_port_range     = "*"
      destination           = "*"
      destination_port_range = "443"
    }
    "deny_all" = {
      priority              = 4000
      direction             = "Inbound"
      access                = "Deny"
      protocol              = "*"
      source                = "*"
      source_port_range     = "*"
      destination           = "*"
      destination_port_range = "*"
    }
  }
}

resource "azurerm_network_security_rule" "example_rules" {
  for_each = var.nsg_rules

  name                        = each.key
  priority                    = each.value.priority
  direction                   = each.value.direction
  access                      = each.value.access
  protocol                    = each.value.protocol
  source_address_prefix       = each.value.source
  source_port_range           = each.value.source_port_range
  destination_address_prefix  = each.value.destination
  destination_port_range      = each.value.destination_port_range
  network_security_group_name = azurerm_network_security_group.example_nsg.name
  resource_group_name         = azurerm_resource_group.example.name
}

# provides real-time monitoring of allowed/denied traffic
resource "azurerm_network_watcher_flow_log" "test" {
  network_watcher_name = azurerm_network_watcher.test.name
  resource_group_name  = azurerm_resource_group.example.name
  name                 = "example-log"

  target_resource_id = azurerm_network_security_group.example_nsg.id
  storage_account_id = azurerm_storage_account.test.id # sa where flow logs will be stored
  enabled            = true

  retention_policy {
    enabled = true
    days    = 7
  }

  traffic_analytics {
    enabled               = true
    workspace_id          = azurerm_log_analytics_workspace.test.workspace_id
    workspace_region      = azurerm_log_analytics_workspace.test.location
    workspace_resource_id = azurerm_log_analytics_workspace.test.id
    interval_in_minutes   = 10
  }
}
