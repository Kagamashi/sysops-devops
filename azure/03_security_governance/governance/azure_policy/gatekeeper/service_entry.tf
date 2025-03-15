# The policy validates ServiceEntry resources created in Istio-enabled clusters to:
# Enforce proper configuration of the exportTo field:
#   - exportTo field must be present
#   - exportTo field must not be empty
#   - exportTo field must have valid values

resource "azurerm_policy_definition" "service_entry" {
  name         = "k8s-service-entry"
  policy_type  = "Custom"
  mode         = "Microsoft.Kubernetes.Data"
  display_name = "Kubernetes - Service Entry"
  description  = "Constraints for a Service Entry definition by a Service"

  # metadata = "{}"

  policy_rule = jsonencode({
    if = {
      allOf = [
        # Only apply the policy to AKS clusters
        {
          field = "type"
          in = [
            "Microsoft.ContainerService/managedClusters"
          ]
        },

        # Make sure at least 1 namespace is defined
        {
          count = {
            value = "[parameters('namespaces')]"
          }
          greater = 0
        }
      ]
    }
    then = {
      effect = "[parameters('effect')]"
      details = {
        templateInfo = {
          sourceType = "Base64Encoded"
          content = base64encode(<<-EOF
            apiVersion: templates.gatekeeper.sh/v1beta1
            kind: ConstraintTemplate
            metadata:
              name: serviceserviceentry
            spec:
              crd:
                spec:
                  names:
                    kind: serviceServiceEntry
              targets:
                - target: admission.k8s.gatekeeper.sh
                  rego: |
                    package serviceserviceentry

                    violation[{"msg": msg}] {
                      not input.review.object.spec.exportTo
                      msg := "exportTo is missing"
                    }

                    violation[{"msg": msg}] {
                      count(input.review.object.spec.exportTo) == 0
                      msg := "exportTo is empty"
                    }

                    violation[{"msg": msg}] {
                      input.review.object.spec.exportTo[i] != "."
                      msg := sprintf("invalid exportTo value: %s", [input.review.object.spec.exportTo[i]])
                    }
            EOF
          )
        }
        apiGroups = [
          "networking.istio.io"
        ]
        kinds = [
          "ServiceEntry"
        ]
        namespaces = "[parameters('namespaces')]"
        excludedNamespaces = [
          "kube-system",
          "gatekeeper-system",
          "azure-arc"
        ]
        labelSelector = {}
        values        = {}
      }
    }
  })

  parameters = jsonencode({
    effect = {
      type = "String"
      metadata = {
        displayName = "Effect"
        description = "'Audit' allows a non-compliant resource to be created or updated, but flags it as non-compliant. 'Deny' blocks the non-compliant resource creation or update. 'Disabled' turns off the policy."
      }
      allowedValues = [
        "audit",
        "Audit",
        "deny",
        "Deny",
        "disabled",
        "Disabled"
      ]
      defaultValue = "Audit"
    }
    namespaces = {
      type = "Array"
      metadata = {
        displayName = "Namespace inclusions"
        description = "The list of namespaces to include in policy evaluation. At least 1 namespace has to be defined."
      }
    }
  })
}

###

resource "azurerm_resource_policy_assignment" "service_entry" {
  name                 = "service-service-entry"
  resource_id          = module.azure_kubernetes_service.aks.id
  policy_definition_id = resource.azurerm_policy_definition.service_entry.id

  parameters = jsonencode({
    effect = {
      value = "deny"
    }
    namespaces = {
      value = ["app-*"]
    }
  })
}
