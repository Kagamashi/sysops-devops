# Application Insights
# feature of Azure Monitor - gathers live metrics of our apps
#   - automatically detects performance anomalies
#   - provides usage analytics (requests, exceptions, dependencies)
#   - works with .NET, Node.js, Java - in cloud, on-prem, hybrid
#   - integrades with CI/CD

resource "azurerm_application_insights" "example" {
  name                = "tf-test-appinsights"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  application_type    = "web"
}

output "instrumentation_key" {
  value = azurerm_application_insights.example.instrumentation_key
}

output "app_id" {
  value = azurerm_application_insights.example.app_id
}
