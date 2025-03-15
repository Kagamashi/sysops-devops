# Workload Identity
# used in AKS pods for OAuth authentication

resource "azurerm_user_assigned_identity" "uai" {
  name                = "workload-identity"
  location            = data.resource_group.rg.location
  resource_group_name = data.resource_group.rg.name
}

resource "azurerm_federated_identity_credential" "uai" {
  name                = "workload-identity"
  resource_group_name = data.resource_group.rg.name
  parent_id           = azurerm_user_assigned_identity.uai.id

  audience = ["api://AzureADTokenExchange"]
  issuer   = module.azure_kubernetes_service.aks.oidc_issuer_url # in which AKS cluster the identity is used
  subject  = "system:serviceaccount:namespace:service_account_name" 
}

# resource "azurerm_kubernetes_cluster" "example" {
#   ...
#   oidc_issuer_enabled = true    # e OpenID Connect for Workload Identity
#   workload_identity_enabled = true
# }
