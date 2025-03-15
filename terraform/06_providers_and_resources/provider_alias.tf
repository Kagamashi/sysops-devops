# Provider for the West Europe region
provider "azurerm" {
  alias    = "westeurope"
  features {}
}

# Provider for the East Europe region
provider "azurerm" {
  alias    = "easteurope"
  features {}
}

# Resource Group using westeurope provider
resource "azurerm_resource_group" "west_rg" {
  provider = azurerm.westeurope

  name     = "example-west-rg"
  location = "westeurope"
}

# Resource Group using easteurope provider
resource "azurerm_resource_group" "east_rg" {
  provider = azurerm.easteurope

  name     = "example-east-rg"
  location = "easteurope"
}
