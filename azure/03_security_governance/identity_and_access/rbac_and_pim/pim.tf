# Privileged Identity Management [PIM]
# security feature in Microsoft Entra ID that provides JIT access control for privileged roles to reduce the risk of unauthorized access

#   - grant time-limited, on-demand access to privileged roles
#   - require approval & justification before activating high-risk roles
#   - monitor & audit privileged access
#   - enforce MFA for privileged role activation
#   - assigns privileges for a limited period of time

# PIM assignment type:
#   - Eligible: user can activate the role when needed (best practice)
#   - Active: user always has access to the role
#   - Permanent: user is permanently assigned to the role (not recommended)
#   - Time-bound: role is granted for a specific duration


# managed PIM Eligible role assignments
resource "time_static" "example" {}

resource "azurerm_pim_eligible_role_assignment" "example" {
  scope              = data.azurerm_subscription.primary.id
  role_definition_id = "${data.azurerm_subscription.primary.id}${data.azurerm_role_definition.example.id}"
  principal_id       = data.azurerm_client_config.example.object_id

  schedule {
    start_date_time = time_static.example.rfc3339
    expiration {
      duration_hours = 8
    }
  }

  justification = "Expiration Duration Set"

  ticket {
    number = "1"
    system = "example ticket system"
  }
}

# list active PIM assignments
# az role assignment list --query "[].{Role:roleDefinitionName, User:principalName}" --output table

# check PIM audit logs
# az monitor activity-log list --resource-group rg-pim --output table

# activate an eligible PIM role via CLI
# az role assignment create --assignee user@example.com --role "Global Administrator" --subscription <subscription-id>
