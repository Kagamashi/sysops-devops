locals {
  external_jobs_permissions = [
    "Microsoft.ContainerRegistry/registries/PrivateEndpointConnectionsApproval/action",
    "Microsoft.ContainerRegistry/registries/write",
    "Microsoft.ContainerService/managedClusters/accessProfiles/listCredential/action",
    "Microsoft.ContainerService/managedClusters/listClusterAdminCredential/action",
    "Microsoft.ContainerService/managedClusters/read",
    "Microsoft.EventHub/namespaces/authorizationRules/listKeys/action",
    "Microsoft.Insights/diagnosticSettings/write",
    "Microsoft.KeyVault/vaults/PrivateEndpointConnectionsApproval/action",
    "Microsoft.KeyVault/vaults/read",
    "Microsoft.KeyVault/vaults/write",
    "Microsoft.ManagedIdentity/userAssignedIdentities/write",
    "Microsoft.ManagedIdentity/userAssignedIdentities/federatedIdentityCredentials/write",
    "Microsoft.Network/privateDnsZones/join/action",
    "Microsoft.Network/privateEndpoints/write",
    "Microsoft.Network/privateEndpoints/privateDnsZoneGroups/write",
    "Microsoft.Network/virtualNetworks/subnets/join/action",
    "Microsoft.Resources/deployments/*",
    "Microsoft.Resources/subscriptions/resourceGroups/write",
    "Microsoft.Storage/storageAccounts/listKeys/action",
    # ...
  ]
}

resource "azurerm_role_definition" "custom_role" {
  name        = "[Custom] Role"
  description = "Custom role with only required permissions"
  scope       = data.azurerm_subscription.subscription.id

  permissions {
    actions = local.external_jobs_permissions # List of actions based on locals
  }
}

resource "azurerm_role_assignment" "custom_role" {
  scope                = data.azurerm_subscription.subscription.id
  role_definition_name = azurerm_role_definition.custom_role.name
  principal_id         = azurerm_user_assigned_identity.uai.principal_id
}
