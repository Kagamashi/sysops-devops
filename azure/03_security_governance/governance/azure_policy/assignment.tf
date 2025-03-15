# POLICY ASSIGNMENTS
data "azurerm_virtual_network" "example" {
  name                = "production"
  resource_group_name = "networking"
}

resource "azurerm_resource_policy_assignment" "example" {
  name                 = "example-policy-assignment"
  resource_id          = data.azurerm_virtual_network.example.id
  policy_definition_id = azurerm_policy_definition.example.id
}


# SUNSCRIPTION SCOPE
data "azurerm_subscription" "current" {}

resource "azurerm_subscription_policy_assignment" "example" {
  name                 = "example"
  policy_definition_id = azurerm_policy_definition.example.id
  subscription_id      = data.azurerm_subscription.current.id
}


# RESOURCE GROUP SCOPE
resource "azurerm_resource_group" "example" {
  name     = "example-resources"
  location = "West Europe"
}

resource "azurerm_resource_group_policy_assignment" "example" {
  name                 = "example"
  resource_group_id    = azurerm_resource_group.example.id
  policy_definition_id = azurerm_policy_definition.example.id

  parameters = <<PARAMS
    {
      "tagName": {
        "value": "Business Unit"
      },
      "tagValue": {
        "value": "BU"
      }
    }
PARAMS
}


# MANAGEMENT GROUP SCOPE
resource "azurerm_management_group" "example" {
  display_name = "Some Management Group"
}

resource "azurerm_management_group_policy_assignment" "example" {
  name                 = "example-policy"
  policy_definition_id = azurerm_policy_definition.example.id
  management_group_id  = azurerm_management_group.example.id
}
