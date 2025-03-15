
# using SERVICE PRINCIPAL authentication
# export ARM_CLIENT_ID="your-client-id"
# export ARM_CLIENT_SECRET="your-client-secret"
# export ARM_TENANT_ID="your-tenant-id"
# export ARM_SUBSCRIPTION_ID="your-subscription-id"

variable client_id {}
variable client_secret {}
variable tenant_id {}
variable subscription_id{}

provider "azurerm" {
  features {}
  client_id       = var.client_id
  client_secret   = var.client_secret
  tenant_id       = var.tenant_id
  subscription_id = var.subscription_id

  # Managed Identity Authentication (VM/AKS)
  use_msi = true
}
