# Availability Sets [99.95% SLA]
#   distributes VMs across fault domains (physical hardware racks)
resource "azurerm_availability_set" "example" {
  name                = "example-avset"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  platform_fault_domain_count = 3   # physical rack grouping that shares power/network
  platform_update_domain_count = 5  # grouping of VMs for rolling software updates
}

###

# Availability Zones [99.99% SLA]
#   distributes VMs across different physical data centers in a region
#   independent power/cooling/network
# Zone = fault domain + update domain

# resource "azurerm_virtual_machine" "example" {
#   ...
#   availability_zone   = "1"   # !!!
# }
