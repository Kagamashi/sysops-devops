# https://learn.microsoft.com/pl-pl/training/modules/sovereignty-policy-initiatives/azure-policy-definitions

# The effect parameter determines the behavior of the policy:
#   audit: Allows the resource to be created but flags it as non-compliant in Azure Policy.
#   deny: Prevents the creation or update of non-compliant resources.
#   disabled: Turns off the policy.

resource "azurerm_policy_definition" "policy" {
  name         = "accTestPolicy"
  policy_type  = "Custom"
  mode         = "Indexed" # | All | Microsoft.Kubernetes.Data...
  display_name = "acceptance test policy definition"
  description   = ""

  metadata = <<METADATA
    {
    "category": "General"
    }
METADATA

# Logical operators support in IF block:
#   - not
#   - allOf - (and) requires all conditions to be true
#   - anyOf - (or) one or more conditions to be true

# Properties in conditions:
#   - fields: Name, fullName, kind, type, location, ID, identity.type, tags, tags['tagName'], property aliases
#   - value
#   - count - how many members of an array meet certain criteria

# Policy rule defines the logic to evaluate resources
  policy_rule = <<POLICY_RULE
"if": { # when policy applies
    "allOf": [
      {
        "not": {
          "field": "tags",
          "containsKey": "application"
        }
      },
      {
        "field": "type",
        "equals": "Microsoft.Storage/storageAccounts"
      }
    ]
  },
  "then": {
    "effect": "deny",
    "details": {
      "count": {
        "field": "Microsoft.Network/virtualNetworks/addressSpace.addressPrefixes[*]",
        "where": {
          "value": "[ipRangeContains('10.0.0.0/24', current('Microsoft.Network/virtualNetworks/addressSpace.addressPrefixes[*]'))]",
          "equals": "greater"
        }
      }
    }
  }
}
POLICY_RULE

# Parameters allow to create reusable policies by making some values configurable
  parameters = <<PARAMETERS
  {
    "allowedLocations": {
      "type": "Array",
      "metadata": {
        "description": "The list of allowed locations for resources.",
        "displayName": "Allowed locations",
        "strongType": "location"
      }
    }
  }
PARAMETERS
}
