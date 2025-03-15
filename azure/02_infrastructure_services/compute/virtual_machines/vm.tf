# Azure Virtual Machines (VMs)
# on-demand, scalable compute resources that allows running workloads in the cloud

# Use caes:
#   - hosting web apps, databases, custom apps
#   - running legacy workloads that need a specific OS
#   - deploying high-performance computing HPC workloads
#   - building development and test environments
#   - running applications requiring GPU acceleration

# VM Sizes & Series:
#   - General Purpose: B, D, DSv2, Av2
#   - Compute Optimized: F, Fs, HB, HC (high CPU)
#   - Memory Optimized: E, Es, M, Mv2 (large RAM)
#   - Storage Optimized: Ls, Lsv2 (high disk I/O)
#   - GPU Optimized: NC, ND, NV (ML, AI, video)
#   - High Performance Computing (HPC): HB, HC, ND (deep learning)
# Use the latest series (Dv5, Ev5, etc.) for better performance per cost

###

resource "azurerm_linux_virtual_machine" "example" {
  name                = "example-machine"
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location
  size                = "Standard_F2"
  admin_username      = "adminuser"
  custom_data = base64encode(file("cloud-init-script.sh")) # bootstrap

  network_interface_ids = [
    azurerm_network_interface.example.id,
  ]

  admin_ssh_key {
    username   = "adminuser"
    public_key = file("~/.ssh/id_rsa.pub")
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }
}

# shutdown to save on costs; good for jumphosts
resource "azurerm_dev_test_global_vm_shutdown_schedule" "example" {
  virtual_machine_id = azurerm_linux_virtual_machine.example.id
  location           = azurerm_resource_group.example.location
  enabled            = true

  daily_recurrence_time = "1100"
  timezone              = "Pacific Standard Time"

  notification_settings {
    enabled         = true
    time_in_minutes = "60"
    webhook_url     = "https://sample-webhook-url.example.com"
  }
}

# azurerm_virtual_machine_run_command is used to execute scripts inside VM after deployment
# basic example
resource "azurerm_virtual_machine_run_command" "example" {
  name               = "example-vmrc"
  location           = azurerm_resource_group.example.location
  virtual_machine_id = azurerm_linux_virtual_machine.example.id
  source {
    script = "echo 'hello world'"
  }
}

# authorize to storage blob using user assigned identity
resource "azurerm_virtual_machine_run_command" "example2" {
  location           = azurerm_resource_group.example.location
  name               = "example2-vmrc"
  virtual_machine_id = azurerm_linux_virtual_machine.example.id
  output_blob_uri    = azurerm_storage_blob.example2.id
  error_blob_uri     = azurerm_storage_blob.example3.id
  run_as_password    = "P@$$w0rd1234!"
  run_as_user        = "adminuser"

  source {
    script_uri = azurerm_storage_blob.example1.id
    script_uri_managed_identity {
      client_id = azurerm_user_assigned_identity.example.client_id
    }
  }

  error_blob_managed_identity {
    client_id = azurerm_user_assigned_identity.example.client_id
  }

  output_blob_managed_identity {
    client_id = azurerm_user_assigned_identity.example.client_id
  }

  parameter {
    name  = "examplev1"
    value = "val1"
  }

  protected_parameter {
    name  = "examplev2"
    value = "val2"
  }

  tags = {
    environment = "terraform-examples"
    some_key    = "some-value"
  }

  depends_on = [
    azurerm_role_assignment.example,
  ]
}

# authorize to storage blob using SAS token
resource "azurerm_virtual_machine_run_command" "example3" {
  location           = azurerm_resource_group.example.location
  name               = "example3-vmrc"
  virtual_machine_id = azurerm_linux_virtual_machine.example.id
  run_as_password    = "P@$$w0rd1234!"
  run_as_user        = "adminuser"
  error_blob_uri     = "${azurerm_storage_blob.example3.id}${data.azurerm_storage_account_sas.example.sas}"
  output_blob_uri    = "${azurerm_storage_blob.example2.id}${data.azurerm_storage_account_sas.example.sas}"

  source {
    script_uri = "${azurerm_storage_blob.example1.id}${data.azurerm_storage_account_sas.example.sas}"
  }

  parameter {
    name  = "example-vm1"
    value = "val1"
  }

  tags = {
    environment = "terraform-example-s"
    some_key    = "some-value"
  }
}
