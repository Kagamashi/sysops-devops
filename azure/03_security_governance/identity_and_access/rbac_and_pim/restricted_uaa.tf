data azurerm_role_definition reader {
  name = "Reader"
  scope = data.azurerm_subscription.current.id
}
# ...

locals {
  reader_id_list           = split("/", data.azurerm_role_definition.reader.role_definition_id)
  security_reader_id       = split("/", data.azurerm_role_definition.security_reader.role_definition_id)
  acr_pull_id_list         = split("/", data.azurerm_role_definition.acr_pull.role_definition_id)
  acr_push_id_list         = split("/", data.azurerm_role_definition.acr_push.role_definition_id)
  acr_delete_id_list       = split("/", data.azurerm_role_definition.acr_delete.role_definition_id)
  kv_secret_writer         = split("/", data.azurerm_role_definition.kv_secret_writer.role_definition_id)
  kv_secret_user           = split("/", data.azurerm_role_definition.kv_secrets_user.role_definition_id)
  kv_certificate_writer    = split("/", data.azurerm_role_definition.kv_certificate_writer.role_definition_id)

  role_ids = [
    element(local.kv_secret_user, length(local.kv_secret_user) - 1),
    element(local.kv_secret_writer, length(local.kv_secret_writer) - 1),
    element(local.kv_certificate_writer, length(local.kv_certificate_writer) - 1),
    element(local.reader_id_list, length(local.reader_id_list) - 1),
    element(local.security_reader_id, length(local.security_reader_id) - 1),
    element(local.acr_pull_id_list, length(local.acr_pull_id_list) - 1),
    element(local.acr_push_id_list, length(local.acr_push_id_list) - 1),
    element(local.acr_delete_id_list, length(local.acr_delete_id_list) - 1),
  ]

  role_ids_string = join(", ", local.role_ids)
}

resource "azurerm_role_assignment" "uai_uaa" {
  principal_id         = azurerm_user_assigned_identity.example.principal_id
  principal_type       = "ServicePrincipal"
  scope                = data.azurerm_subscription.current.id
  role_definition_name = "User Access Administrator"
  condition_version    = "2.0"
  condition            = <<-EOT
(
 (
  !(ActionMatches{'Microsoft.Authorization/roleAssignments/write'})
 )
 OR
 (
  @Request[Microsoft.Authorization/roleAssignments:RoleDefinitionId] ForAnyOfAnyValues:GuidEquals {${local.role_ids_string}}
 )
)
AND
(
 (
  !(ActionMatches{'Microsoft.Authorization/roleAssignments/delete'})
 )
 OR
 (
  @Resource[Microsoft.Authorization/roleAssignments:RoleDefinitionId] ForAnyOfAnyValues:GuidEquals {${local.role_ids_string}}
 )
)
EOT
}
