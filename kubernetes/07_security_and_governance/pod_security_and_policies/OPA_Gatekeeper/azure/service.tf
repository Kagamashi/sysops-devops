resource "azurerm_policy_definition" "service" {
  name         = "k8s-service"
  policy_type  = "Custom"
  mode         = "Microsoft.Kubernetes.Data"
  display_name = "Kubernetes - Service"
  description  = "This policy ensures that only specific, allowed Kubernetes Service types are used in the cluster. By restricting disallowed types."

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
              name: serviceservice
            spec:
              crd:
                spec:
                  names:
                    kind: serviceService
              targets:
                - target: admission.k8s.gatekeeper.sh
                  rego: |
                    package serviceservice

                    import future.keywords.in

                    # Check that the Service type is not using a blocked type
                    violation[{"msg": msg}] {
                      input.review.object.spec.type in {"ExternalName", "NodePort", "LoadBalancer"}
                      msg := sprintf("invalid Service type: %s", [input.review.object.spec.type])
                    }
            EOF
          )
        }
        apiGroups = [
          ""
        ]
        kinds = [
          "Service"
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

resource "azurerm_resource_policy_assignment" "service" {
  name                 = "app-service"
  resource_id          = module.azure_kubernetes_service.aks.id
  policy_definition_id = resource.azurerm_policy_definition.service.id

  parameters = jsonencode({
    effect = {
      value = "deny"
    }
    namespaces = {
      value = ["app-*"]
    }
  })
}
