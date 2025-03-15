
/* DYNAMIC BLOCKS
Dynamic blocks allow creating multiple instances of a nested argument or block based on a list or map of inputs.
This reduces code duplication for similar resources or attributes.
*/

/* In this example, the security rules are defined dynamically using the `for_each` iterator. 
  - `for_each`: Iterates over the list of `security_rules`.
  - `content`: Defines the attributes of the dynamically created `security_rule` block. */

resource "azurerm_network_security_group" "example" {
  name                = "example-nsg"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name

  dynamic "security_rule" {
    for_each = var.security_rules  # Iterate over the list of security rules
    content {
      name                       = security_rule.value.name
      priority                   = security_rule.value.priority
      direction                  = security_rule.value.direction
      access                     = security_rule.value.access
      protocol                   = security_rule.value.protocol
      source_port_range          = security_rule.value.source_port_range
      destination_port_range     = security_rule.value.destination_port_range
      source_address_prefix      = security_rule.value.source_address_prefix
      destination_address_prefix = security_rule.value.destination_address_prefix
    }
  }
}

variable "security_rules" {
  description = "List of security rules for the network security group"
  type = list(object({
    name                       = string
    priority                   = number
    direction                  = string
    access                     = string
    protocol                   = string
    source_port_range          = string
    destination_port_range     = string
    source_address_prefix      = string
    destination_address_prefix = string
  }))
  default = [
    {
      name                       = "Allow-SSH"
      priority                   = 100
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "22"
      source_address_prefix      = "*"
      destination_address_prefix = "*"
    },
    {
      name                       = "Allow-HTTP"
      priority                   = 200
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "80"
      source_address_prefix      = "*"
      destination_address_prefix = "*"
    }
  ]
}

/* DYNAMIC EXPRESSIONS
Dynamic expressions allow writing conditional logic in Terraform configurations.
These expressions are useful for defining attributes or resources based on conditions.
*/
resource "azurerm_linux_virtual_machine" "example" {
  count = var.environment == "prod" || var.environment == "nonprod" ? 1 : 0  # Create VM only for prod and nonprod environment

  name                = "example-vm"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  size                = var.instance_type

  admin_username = "azureuser"
  admin_password = "P@ssw0rd1234!"

  network_interface_ids = [azurerm_network_interface.example.id]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = var.environment == "prod" ? "Premium_LRS" : "Standard_LRS"  # Use Premium for prod, Standard otherwise
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }
}

variable "instance_type" {
  description = "The size of the VM"
  type        = string
  default     = "Standard_B1s"
}

variable "environment" {
  description = "The environment for the deployment"
  type        = string
  default     = "dev"
}
