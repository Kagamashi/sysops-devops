# Azure App Service
# fully managed platform for hosting 
#   Web apps: ASP.NET, Java, Node.js, PHP, Python, Ruby
#   API apps: RESTful APIs
#   WebJobs: background tasks
#   Mobile apps: iOS, Android, Windows

#   - supports HTTPS, Azure Front Door, Application Gateway
#   - manual and auto-scaling based on parameters
#   - CI/CD integration: GitHub, Bitbucket, Azure DevOps
#   - multiple language support: ASP.NET, Java, Node.js, PHP, Python, Ruby, plus custom scripts
#   - serverless code: run code snippers or script on-demand (pay only for used compute)

# Deployment slots:
#  - possibility to deploy new versions of our app without affecting production
#  - Staging slot: test changes in a live environment
#  - Swap: seamlessly swap staging with production to avoid downtime
#  - Auto swap: enable zero-downtime continuous deployments
# Retain last known good site by swapping back if needed

# Custom domains:
# by default app is reachable at <appname>.azurewwebsites.net
#   1. Buy domain from Azure or 3rd party
#   2. Add A or CNAME record to map new domain to <appname>.azurewebsites.net
#      CNAME doesn't break if IP changes
#   3. Validate and enable


resource "azurerm_linux_web_app" "example" {
  name                = "example-linux-web-app"
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_service_plan.example.location
  service_plan_id     = azurerm_service_plan.example.id

  site_config {}
}

resource "azurerm_linux_web_app_slot" "example" {
  name           = "example-slot"
  app_service_id = azurerm_linux_web_app.example.id

  site_config {}
}

# GitHub Deployment
resource "azurerm_app_service_source_control" "example" {
  app_id                 = azurerm_app_service.example.id
  repo_url               = "https://github.com/your-repo/webapp"
  branch                 = "main"
  rollback_enabled       = false
  use_manual_integration = true
}

# private endpoint for App Service (disables public internet access)
resource "azurerm_private_endpoint" "example" {
  name                = "webapp-private-endpoint"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  subnet_id           = azurerm_subnet.example.id

  private_service_connection {
    name                           = "webapp-private-link"
    private_connection_resource_id = azurerm_app_service.example.id
    is_manual_connection           = false
  }
}

# allows app to securely commmunicate with databases inside Azure VNET
resource "azurerm_app_service_virtual_network_swift_connection" "example" {
  app_service_id = azurerm_app_service.example.id
  subnet_id      = azurerm_subnet.example.id
}
