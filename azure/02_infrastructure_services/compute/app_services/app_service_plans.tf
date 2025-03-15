# Azure App Service Plan
# defines compute resources (VMs) that power the apps, scaling them as needed
# multiple apps can share a plan, but they also share the same resources

#   Free - single shared VM, no SLA
#   Basic - up to 3 instances, custom domains
#   Standard - up to 10 instance, autoscale, staging slots, daily backups
#   Premium - up to 30 instances, better CPU/memory, advanced networking
#   Isolated - up to 100 (App Service Environment), dedicated VMs, VNET

# Scaling:
#   - Scale Up: increase pricing tier for more CPU/RAM and advanced features; no code changes or redeploy needed
#   - Scape Out: increate number of VM instances (possible autoscale) 

resource "azurerm_app_service_plan" "example" {
  name                = "api-appserviceplan-pro"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  kind                = "Linux"
  reserved            = true

  sku {
    tier = "Standard"
    size = "S1"
  }
}
