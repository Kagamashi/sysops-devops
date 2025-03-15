resource "azurerm_policy_definition" "virtual_service" {
  name         = "k8s-virtual-service"
  policy_type  = "Custom"
  mode         = "Microsoft.Kubernetes.Data"
  display_name = "Kubernetes - Virtual Service"
  description  = "Enforces constraints on Kubernetes VirtualService resources in an AKS (Azure Kubernetes Service) cluster."

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
              name: servicevirtualservice
            spec:
              crd:
                spec:
                  names:
                    kind: serviceVirtualService
                  validation:
                    # Schema for the `parameters` field
                    openAPIV3Schema:
                      type: object
                      properties:
                        gateways:
                          description: The list of allowed gateways.
                          type: array
                          items:
                            type: string
                        hosts:
                          description: The list of allowed hosts.
                          type: array
                          items:
                            type: string
              targets:
                - target: admission.k8s.gatekeeper.sh
                  rego: |
                    package servicevirtualservice

                    import future.keywords.in

                    # Check that gateways are only in the list of allowed gateways
                    violation[{"msg": msg}] {
                      gateways = [gateway | gateway := input.review.object.spec.gateways[_]; not gateway in input.parameters.gateways]
                      count(gateways) > 0
                      msg := sprintf("invalid gateways: %v", [gateways])
                    }

                    # Check that hosts are only in the list of allowed hosts
                    violation[{"msg": msg}] {
                      hosts = [host | host := input.review.object.spec.hosts[_]; not host in input.parameters.hosts]
                      count(hosts) > 0
                      msg := sprintf("invalid hosts: %v", [hosts])
                    }

                    # Check the host name of a route destination
                    #   - If there is no namespace defined the route is ok
                    #     (by default if no namespace is defined the namespace of the VS is used)
                    check_route_host(host) = true {
                      not contains(host, ".")
                    }
                    #   - If there is a namespace defined the route is ok
                    #     as long as the namespace of the VS is used
                    check_route_host(host) = true {
                      contains(host, ".")
                        ns := split(host, ".")[1]
                        ns == input.review.object.metadata.namespace
                    }

                    # Check all rules & routes for a given rule type
                    check_route_rules[{"msg": msg, "rule": rule}] {
                      some rules in input.review.object.spec[rule]
                      some route in rules.route
                      not check_route_host(route.destination.host)
                      msg := sprintf("invalid host for %s destination: %s", [rule, route.destination.host])
                    }

                    # Check all destination host names
                    violation[{"msg": msg}] {
                      check_route_rules[{"msg": msg, "rule": "http"}]
                    }
                    violation[{"msg": msg}] {
                      check_route_rules[{"msg": msg, "rule": "tls"}]
                    }
                    violation[{"msg": msg}] {
                      check_route_rules[{"msg": msg, "rule": "tcp"}]
                    }
            EOF
          )
        }
        apiGroups = [
          "networking.istio.io"
        ]
        kinds = [
          "VirtualService"
        ]
        namespaces = "[parameters('namespaces')]"
        excludedNamespaces = [
          "kube-system",
          "gatekeeper-system",
          "azure-arc"
        ]
        labelSelector = {}
        values = {
          gateways = "[parameters('gateways')]"
          hosts    = "[parameters('hosts')]"
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
    gateways = {
      type = "Array"
      metadata = {
        displayName = "Allowed gateways"
        description = "The list of allowed gateways."
      }
    }
    hosts = {
      type = "Array"
      metadata = {
        displayName = "Allowed hosts"
        description = "The list of allowed hosts."
      }
    }
  })
}

###

# No policy assignment as the assignment is service specific
