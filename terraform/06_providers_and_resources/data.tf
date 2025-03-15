data "azurerm_resource_group" "existing" {
  name = "my-resource-group"
}

resource "azurerm_subnet" "example" {
  name                = "example-nic"
  virtual_network_name = "abc"
  address_prefixes = "10.0.0.2/24"
  resource_group_name = data.azurerm_resource_group.existing.name # data reference
}
