
# Note that after you’ve used count on a resource,  
# it becomes an array of resources rather than just one resource.  
# Count on module turns it into an array of modules. 


# conditional resource creation with count (count as if-else statement)
variable "create_instance" {
  type    = bool
  default = true
}

resource "azurerm_resource_group" "example" {
  count = var.create_instance ? 1 : 0  # Create the VM only if the condition is true

  name                = "example-vm"
  location            = azurerm_resource_group.example.location
}


# working with lists using count
# each instance can be accessed using an index (e.g., azurerm_linux_virtual_machine.my_instance[0]).
variable "vm_sizes" {
  type    = list(string)
  default = ["Standard_B1s", "Standard_B2s", "Standard_B2ms"]
}

resource "azurerm_linux_virtual_machine" "example" {
  count                = length(var.vm_sizes)  # Number of VMs matches the length of the list

  name                 = "example-vm-${count.index + 1}"
  resource_group_name  = azurerm_resource_group.example.name
  location             = azurerm_resource_group.example.location
  size                 = var.vm_sizes[count.index]  # Use a different size for each VM

  admin_username = "azureuser"
  admin_password = "P@ssw0rd1234!"

  network_interface_ids = [azurerm_network_interface.example[count.index].id]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }
}
