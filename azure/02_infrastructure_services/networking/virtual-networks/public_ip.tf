
resource "azurerm_public_ip" "example" {
  name                = "acceptanceTestPublicIp1"
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location
  allocation_method   = "Static"
}
# If this resource is to be associated with a resource that requires disassociation before destruction (such as azurerm_network_interface) 
# it is recommended to set the lifecycle argument create_before_destroy = true. 
# Otherwise, it can fail to disassociate on destruction.
