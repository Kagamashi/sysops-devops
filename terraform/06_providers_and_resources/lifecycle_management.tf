
# create_before_destroy
# ignore_changes
# prevent_destroy

resource "azurerm_linux_virtual_machine" "example_vm" {
  name                = "example-vm"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  size                = "Standard_B1s"

  admin_username = "azureuser"
  admin_password = "P@ssw0rd1234!"  # Replace with a secure password

  network_interface_ids = [azurerm_network_interface.example.id]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
    disk_size_gb         = 64  # OS disk size
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }

  lifecycle {
    create_before_destroy = true  # Terraform creates new resource before destroying the old one

    prevent_destroy = true        # Avoid accidentaly destroying critical infrastructure

    ignore_changes = [            # Prevents Terraform from trying to overwrite manual changes
      os_disk[0].disk_size_gb,    # If disk size is changed manually, Terraform will ignore that change and not attempt to modify it
      admin_password 
    ]
  }
}
