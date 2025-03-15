# If pod have toleration with key 'CriticalAddonsOnly' set it's marked as non-compliant.

resource "azurerm_policy_definition" "tolerations" {
  name         = "k8s-pod-tolerations"
  policy_type  = "Custom"
  mode         = "Microsoft.Kubernetes.Data"
  display_name = "Kubernetes - Pod - Tolerations"
  description  = "Ensures that tolerations used in Pods are compliant with governance standards."

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
              name: servicetolerations
            spec:
              crd:
                spec:
                  names:
                    kind: serviceTolerations
              targets:
                - target: admission.k8s.gatekeeper.sh
                  rego: |
                    package servicetolerations

                    import future.keywords.in

                    # Check that tolerations are not referencing 'CriticalAddonsOnly'
                    # which is used in conjunction with the system node pool(s)
                    violation[{"msg": msg}] {
                      some toleration in input.review.object.spec.Tolerations
                      toleration.key == "CriticalAddonsOnly"
                      msg := sprintf("invalid toleration: %v", [toleration])
                    }
            EOF
          )
        }
        apiGroups = [
          ""
        ]
        kinds = [
          "Pod"
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

resource "azurerm_resource_policy_assignment" "tolerations" {
  name                 = "service-tolerations"
  resource_id          = module.azure_kubernetes_service.aks.id
  policy_definition_id = resource.azurerm_policy_definition.tolerations.id

  parameters = jsonencode({
    effect = {
      value = "deny"
    }
    namespaces = {
      value = ["app-*"]
    }
  })
}
