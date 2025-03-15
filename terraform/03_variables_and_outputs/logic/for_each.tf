
# for_each allows you to create resources for each item in MAP, SET and OBJECT
# it’s more flexible than count as it allows the creation of resources based on key-value pairs.

# for_each with a LIST
variable "resource_group_names" {
  type    = list(string)
  default = ["web", "app", "db"]
}

resource "azurerm_resource_group" "example" {
  for_each = toset(var.resource_group_names)  # Convert the list to a set for iteration

  name     = "${each.key}-rg"  # Each resource group gets a unique name
  location = "East US"
  tags = {
    Name = each.key  # Tag each resource group with its name
  }
}


# for_each with a MAP
variable "storage_account_configs" {
  type = map(string)
  default = {
    "web" = "Standard_LRS"
    "app" = "Standard_GRS"
    "db"  = "Standard_ZRS"
  }
}

resource "azurerm_storage_account" "example" {
  for_each = var.storage_account_configs  # Iterate over the map
  
  name                     = "${each.key}storageacct"  # Use the key as the name prefix
  resource_group_name      = azurerm_resource_group.example.name
  location                 = "East US"
  account_tier             = "Standard"
  account_replication_type = each.value  # Use the replication type from the map
  tags = {
    Environment = each.key
  }
}


# for_each with unique OBJECTS
variable "nsg_rules" {
  type = map(object({
    priority        = number
    direction       = string
    access          = string
    protocol        = string
    source_port     = string
    destination_port = string
    source_address  = string
    destination_address = string
  }))

  default = {
    ssh = {
      priority        = 100
      direction       = "Inbound"
      access          = "Allow"
      protocol        = "Tcp"
      source_port     = "*"
      destination_port = "22"
      source_address  = "*"
      destination_address = "*"
    },
    http = {
      priority        = 200
      direction       = "Inbound"
      access          = "Allow"
      protocol        = "Tcp"
      source_port     = "*"
      destination_port = "80"
      source_address  = "*"
      destination_address = "*"
    }
  }
}

resource "azurerm_network_security_rule" "example" {
  for_each = var.nsg_rules  # Create a rule for each entry in the map

  name                        = each.key
  priority                    = each.value.priority
  direction                   = each.value.direction
  access                      = each.value.access
  protocol                    = each.value.protocol
  source_port_range           = each.value.source_port
  destination_port_range      = each.value.destination_port
  source_address_prefix       = each.value.source_address
  destination_address_prefix  = each.value.destination_address
  network_security_group_name = azurerm_network_security_group.example.name
  resource_group_name         = azurerm_resource_group.example.name
}
