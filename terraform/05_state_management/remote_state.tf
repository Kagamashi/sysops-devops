/*
for Azure SA
- use RBAC for fine-grained access
- use private endpoints to restrict network exposure
- enable blob soft delete to recover deleted states
*/

terraform {
  backend "azurerm" {
    resource_group_name  = "tf-state-rg"
    storage_account_name = "terraformstate"
    container_name       = "tfstate"
    key                  = "prod.terraform.tfstate"
  }
}
