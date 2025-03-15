# Cost Optimization:
#   - Reserved Instances (RI) - pre-pay for VMs for 1-3 years to save up to 72%
#   good for predictable workloads
resource "azurerm_capacity_reservation_group" "example" {
  name                = "example-capacity-reservation-group"
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location
}

resource "azurerm_capacity_reservation" "example" {
  name                          = "example-capacity-reservation"
  capacity_reservation_group_id = azurerm_capacity_reservation_group.example.id
  sku {
    name     = "Standard_D2s_v3"
    capacity = 1 # amount of instances to be reserved
  }
}

#   - Spot VMs - up to 90% lower cost
#   good for batch jobs, CI/CD, fault-tolerant applications
# resource "azurerm_virtual_machine" "example" {
#   ...
#   priority = spot   # !!!
# }
