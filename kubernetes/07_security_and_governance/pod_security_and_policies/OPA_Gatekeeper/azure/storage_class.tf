resource "azurerm_policy_definition" "storage_class" {
  name         = "k8s-pvc-storage-class"
  policy_type  = "Custom"
  mode         = "Microsoft.Kubernetes.Data"
  display_name = "Kubernetes PVC - Storage Class"
  description  = "Enforce governance by ensuring only approved storage classes are used in PVCs."

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
              name: servicestorageclass
            spec:
              crd:
                spec:
                  names:
                    kind: serviceStorageClass
                  validation:
                    # Schema for the `parameters` field
                    openAPIV3Schema:
                      type: object
                      properties:
                        storageClasses:
                          description: The list of allowed storage classes.
                          type: array
                          items:
                            type: string
              targets:
                - target: admission.k8s.gatekeeper.sh
                  rego: |
                    package servicestorageclass

                    import future.keywords.in

                    # Check that the storage class is specified
                    violation[{"msg": msg}] {
                      not input.review.object.spec.storageClassName
                      msg := "storageClassName has to be specified"
                    }

                    # Check that the storage class is one of the allowed classes
                    violation[{"msg": msg}] {
                      not input.review.object.spec.storageClassName in input.parameters.storageClasses
                      msg := sprintf("invalid storageClassName: %s", [input.review.object.spec.storageClassName])
                    }
            EOF
          )
        }
        apiGroups = [
          ""
        ]
        kinds = [
          "PersistentVolumeClaim"
        ]
        namespaces = "[parameters('namespaces')]"
        excludedNamespaces = [
          "kube-system",
          "gatekeeper-system",
          "azure-arc"
        ]
        labelSelector = {}
        values = {
          storageClasses = "[parameters('storageClasses')]"
        }
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
    storageClasses = {
      type = "Array"
      metadata = {
        displayName = "Allowed storage classes"
        description = "The list of allowed storage classes."
      }
    }
  })
}

###

# No policy assignment as the assignment is service specific
