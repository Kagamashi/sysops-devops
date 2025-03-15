# depends_on explicitly defines a resource's dependency on other resources. 

# This is particularly useful when the dependency is not directly referenced within the resource itself.
# Most of the times Terraform is able to automatically detect the order of dependency

resource "azurerm_linux_virtual_machine" "example" {
  name                = "example-vm"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  size                = "Standard_B1s" # Small VM, similar to t2.micro

  admin_username = "azureuser"
  admin_password = "P@ssw0rd1234!" # Replace with a secure password

  network_interface_ids = [
    azurerm_network_interface.example.id
  ]

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

  depends_on = [azurerm_virtual_network.example]
}

# This ensures that the VNET is created before the VM
