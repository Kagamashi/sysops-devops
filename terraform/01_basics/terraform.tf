# terraform{} block defines TF settings, including required providers and version constraints
terraform {
  # specifies external providers needed for the configuration
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "4.19.0"
    }
  }
}

# configures a specific provider with necessary authentication and region settings
provider "azurerm" {
  # Configuration options
}

# defines an actual infrastructure resource
resource "azurerm_resource_group" "example" {
  name     = "example"
  location = "West Europe"
}
