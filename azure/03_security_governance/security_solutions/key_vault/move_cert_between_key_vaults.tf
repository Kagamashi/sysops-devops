# Code required to move one certificate from one KV to another KV
# without outputting the contents and preserving all the informations inside

variable "certificates" {
  type        = list(string)
  description = "List of certificate names to be copied from first KV to second KV"
  default = [ "test", "test2" ]
}

data "azurerm_key_vault_certificate" "cert" {
  for_each = toset(var.certificates)

  key_vault_id = data.azurerm_key_vault.example.id
  name         = each.value

  depends_on = [
    azurerm_role_assignment.key_vault_secret_reader,
    azurerm_role_assignment.key_vault_certificate_reader,
  ]
}

data "azurerm_key_vault_secret" "cert" {
  for_each = toset(var.certificates)

  key_vault_id = data.azurerm_key_vault.example.id
  name         = each.value

  depends_on = [
    azurerm_role_assignment.key_vault_secret_reader,
  ]
}

resource "azurerm_key_vault_certificate" "cert" {
  for_each = toset(var.certificates)

  key_vault_id = module.keyvault.keyvault.id
  name         = each.value

  certificate {
    contents = data.azurerm_key_vault_secret.cert[each.value].value
  }
  certificate_policy {
    issuer_parameters {
      name = "self"
    }
    key_properties {
      exportable = true
      key_size   = data.azurerm_key_vault_certificate.cert[each.value].certificate_policy[0].key_properties[0].key_size
      key_type   = data.azurerm_key_vault_certificate.cert[each.value].certificate_policy[0].key_properties[0].key_type
      reuse_key  = false
    }
    secret_properties {
      content_type = "application/x-pem-file"
    }
    lifetime_action {
      action {
        action_type = "EmailContacts"
      }
      trigger {
        lifetime_percentage = 80
      }
    }
  }

  depends_on = [
    azurerm_role_assignment.key_vault_secret_writer,
  ]
}
