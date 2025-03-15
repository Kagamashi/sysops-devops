# Azure Functions
# serverless compute service that enables running event-driven code without managing infrastructure
# designed for on-demand execution and scales automatically based on workload demand

# - event-driven - execute functions in response to events (HTTP requests, queues, timers, storage triggers)
# - multiple programming lang - C#, Java, Python, JavaScript, TypeScript, Go, PowerShell
# - seamless integration - works with Azure Services
# - hybrid & on-prem support - can run in App Service Environments (ASE) or Kubernetes (KEDA)

# Hosting plans:
#   - consumption plan - autoscaling, pay-per-use
#   - premium plan - high performance, VNET integration
#   - dedicated plan (App Service Plan) - predictable workloads, enterprise apps

# Triggers:
#   - HTTP trigger - process web requests for APIs
#   - Timer trigger - run jobs at scheduled intervals
#   - Blob Storage trigger - process file uploads
#   - Queue storage trigger - process messages asynchronously
#   - Event Grid trigger - respond to Azure events
#   - CosmosDB trigger - process database changes
#   - Service Bus trigger - integrate with message queues

resource "azurerm_storage_account" "example" {
  name                     = "linuxfunctionappsa"
  resource_group_name      = azurerm_resource_group.example.name
  location                 = azurerm_resource_group.example.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_service_plan" "example" {
  name                = "example-app-service-plan"
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location
  os_type             = "Linux"
  sku_name            = "B1"
}

resource "azurerm_linux_function_app" "example" {
  name                = "example-linux-function-app"
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location

  storage_account_name       = azurerm_storage_account.example.name
  storage_account_access_key = azurerm_storage_account.example.primary_access_key
  service_plan_id            = azurerm_service_plan.example.id

  site_config {}
}
