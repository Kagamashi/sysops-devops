resource "azurerm_resource_group" "example" {
  name     = "resourceGroup1"
  location = "westus"
}

data "azurerm_policy_definition" "example" {
  display_name = "Allowed locations"
}

resource "azurerm_resource_group_policy_assignment" "example" {
  name                 = "exampleAssignment"
  resource_group_id    = azurerm_resource_group.example.id
  policy_definition_id = data.azurerm_policy_definition.example.id
  parameters = jsonencode({
    "listOfAllowedLocations" = {
      "value" = [azurerm_resource_group.example.location]
    }
  })
}

# exempt specific resources from a policy if they have a valid reason.
resource "azurerm_resource_group_policy_exemption" "example" {
  name                 = "exampleExemption"
  resource_group_id    = azurerm_resource_group.example.id
  policy_assignment_id = azurerm_resource_group_policy_assignment.example.id
  exemption_category   = "Mitigated"
}
