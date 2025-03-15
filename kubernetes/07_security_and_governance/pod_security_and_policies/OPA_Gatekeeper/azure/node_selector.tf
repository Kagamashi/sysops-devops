resource "azurerm_policy_definition" "node_selector" {
  name         = "pod-node-selector"
  policy_type  = "Custom"
  mode         = "Microsoft.Kubernetes.Data" # policy applies to Kubernetes data plane resources
  display_name = "Kubernetes - Pod - Node Selector"
  description  = "Ensures that Pods deployed in the Kubernetes cluster cannot explicitly specify which nodes they should run on using the nodeSelector field."

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
            value = "[parameters('namespaces')]" # Reference to the 'namespaces' parameter
          }
          greater = 0 # The count of namespaces must be greater than 0
        }
      ]
    }
    then = {
      # Action to take if the policy is violated
      effect = "[parameters('effect')]"
      details = {
        templateInfo = {
          sourceType = "Base64Encoded" # Base64-encoded Gatekeeper ConstraintTemplate
          content = base64encode(<<-EOF
            apiVersion: templates.gatekeeper.sh/v1beta1
            kind: ConstraintTemplate
            metadata:
              name: servicenodeselector
            spec:
              crd:
                spec:
                  names:
                    kind: serviceNodeSelector
              targets:
                - target: admission.k8s.gatekeeper.sh
                  rego: |
                    package servicenodeselector

                    # Check that node selector is not set
                    violation[{"msg": msg}] {
                      count(input.review.object.spec.nodeSelector) > 0
                      msg := sprintf("invalid node selector: %v", [input.review.object.spec.nodeSelector])
                    }
            EOF
          )
        }
        # Specify the resources to which the policy applies
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

resource "azurerm_resource_policy_assignment" "node_selector" {
  name                 = "service-node-selector"
  resource_id          = module.azure_kubernetes_service.aks.id
  policy_definition_id = resource.azurerm_policy_definition.node_selector.id

  parameters = jsonencode({
    effect = {
      value = "deny"
    }
    namespaces = {
      value = ["app-*"]
    }
  })
}
