resource "azurerm_policy_definition" "restrict_vm_location" {
  name         = "restrict-vm-location"
  policy_type  = "Custom"
  mode         = "All"
  display_name = "Restrict VM Creation to West Europe"
  description  = "This policy ensures that all VMs are created in the West Europe region."

  policy_rule = jsonencode({
    "if" : {
      "allOf" : [
        {
          "field" : "type",
          "equals" : "Microsoft.Compute/virtualMachines"
        },
        {
          "field" : "location",
          "notEquals" : "westeurope"
        }
      ]
    },
    "then" : {
      "effect" : "Deny"
    }
  })

  parameters = jsonencode({
    location = {
      type = "String"
      metadata = {
        displayName = "Allowed Location"
        description = "Only allows VMs to be created in the specified region."
      }
      defaultValue = "westeurope"
    }
  })
}

resource "azurerm_policy_assignment" "restrict_vm_location" {
  name                 = "restrict-vm-location-assignment"
  policy_definition_id = azurerm_policy_definition.restrict_vm_location.id
  scope               = "/subscriptions/${var.subscription_id}"
  display_name        = "Restrict VM Location Policy Assignment"
  description         = "This assignment enforces VM location restriction to West Europe."

  parameters = jsonencode({
    location = {
      value = "westeurope"
    }
  })

  identity {
    type = "SystemAssigned"
  }
}
