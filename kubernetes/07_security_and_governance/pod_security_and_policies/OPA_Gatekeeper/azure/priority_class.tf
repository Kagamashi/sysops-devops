resource "azurerm_policy_definition" "priority_class" {
  name         = "k8s-pod-priority-class"
  policy_type  = "Custom"
  mode         = "Microsoft.Kubernetes.Data"
  display_name = "Kubernetes - Pod - Priority Class"
  description  = "Ensures that Kubernetes Pods cannot use a priorityClassName unless explicitly allowed. Priority classes are used in Kubernetes to influence the scheduling of Pods and the order in which they are evicted during resource contention."

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
              name: servicepriorityclass
            spec:
              crd:
                spec:
                  names:
                    kind: servicePriorityClass
              targets:
                - target: admission.k8s.gatekeeper.sh
                  rego: |
                    package servicepriorityclass

                    # Check that the priority class is not set
                    violation[{"msg": msg}] {
                      input.review.object.spec.priorityClassName != ""
                      msg := sprintf("invalid priority class: %s", [input.review.object.spec.priorityClassName])
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

resource "azurerm_resource_policy_assignment" "priority_class" {
  name                 = "service-priority-class"
  resource_id          = module.azure_kubernetes_service.aks.id
  policy_definition_id = resource.azurerm_policy_definition.priority_class.id

  parameters = jsonencode({
    effect = {
      value = "deny"
    }
    namespaces = {
      value = ["app-*"]
    }
  })
}
