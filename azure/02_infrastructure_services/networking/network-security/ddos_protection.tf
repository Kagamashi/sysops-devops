# Azure DDoS Protection
# fully managed security service that protects Azure resources against Distributed Denial-of-Service attacks. 

# - Azure allows only one DDoS Protection Plan per region

# - DDoS Basic Plan (default) - included by default for all Azure services
# - DDoS Protection Standard (paid)

# deploys DDoS Protection Standard plan
resource "azurerm_network_ddos_protection_plan" "example" {
  name                = "example-protection-plan"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
}

resource "azurerm_virtual_network" "example" {
  name                = "secure-vnet"
  location            = "East US"
  resource_group_name = "network-rg"
  address_space       = ["10.0.0.0/16"]

  ddos_protection_plan {
    id     = azurerm_network_ddos_protection_plan.example.id
    enable = true
  }
}

# detects attack patterns, sources, impact and sends it to Azure Monitor
resource "azurerm_monitor_diagnostic_setting" "ddos_logging" {
  name                       = "ddos-logs"
  target_resource_id         = azurerm_ddos_protection_plan.example.id
  log_analytics_workspace_id = azurerm_log_analytics_workspace.example.id

  enabled_log {
    category = "DDoSProtectionNotifications"
  }

  enabled_log {
    category = "DDoSMitigationFlowLogs"
  }

  enabled_log {
    category = "DDoSMitigationReports"
  }
}
