# Azure Container Apps
# serverless container platform that simplifies running microservices without direct Kubernetes management

#   - designed for HTTP- or event-driven apps
#   - scales automatically (including scale to zero)
#   - build on open-source tech (KEDA, Dapr, Envoy)
#   - great for microservices with service discovery, traffic splitting, versioning


resource "azurerm_container_app_environment" "example" {
  name                       = "Example-Environment"
  location                   = azurerm_resource_group.example.location
  resource_group_name        = azurerm_resource_group.example.name
  log_analytics_workspace_id = azurerm_log_analytics_workspace.example.id
}

resource "azurerm_container_app" "example" {
  name                         = "example-app"
  container_app_environment_id = azurerm_container_app_environment.example.id
  resource_group_name          = azurerm_resource_group.example.name
  revision_mode                = "Single"

  template {
    container {
      name   = "examplecontainerapp"
      image  = "mcr.microsoft.com/k8se/quickstart:latest"
      cpu    = 0.25
      memory = "0.5Gi"
    }
  }
}