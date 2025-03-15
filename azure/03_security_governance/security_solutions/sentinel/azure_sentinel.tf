# Azure Sentinel
# cloud-native SIEM and SOAR solution in Microsoft Azure
# provides intelligent security analytics and threat detection across an organization's entire infrastructure, enabling proactive threat hunting and automated incident response

# SIEM: Security Information and Event Management
# SOAR: Security Orchestration, Automation, and Response

# How Azure Sentinel works:
#   1️. Collect – Ingests security logs & telemetry from Azure, on-prem, and multi-cloud sources
#   2️. Detect – Uses built-in AI, threat intelligence, and correlation rules to identify anomalies
#   3️. Investigate – Provides real-time dashboards and hunting tools to analyze threats
#   4️. Respond – Automates response actions via playbooks (SOAR), alerts, and incident handling

# Azure Sentinel architecture:
#   1️. Data Connectors – Collect logs from Azure, Microsoft Defender, AWS, Firewalls, Syslog, etc.
#   2️. Log Analytics Workspace – Stores and analyzes ingested data
#   3️. Detection Rules – Uses analytics, UEBA, and AI models to detect threats
#   4️. Workbooks & Dashboards – Provides visualizations for security monitoring
#   5️. Incident Management & SOAR – Automates response actions with playbooks

# Azure Sentinel integrations:
#   - Cloud Security: Azure Security Center, Microsoft Defender for Cloud
#   - On-Prem Security: Syslog, Windows Event Logs, Firewalls
#   - Endpoint Protection (EDR/XDR): Microsoft Defender for Endpoint, SentinelOne, CrowdStrike
#   - SIEM & SOAR: Splunk, Palo Altor Cortex XSOAR, IBM QRadar
#   - Threat Intelligence: Microsoft Threat Intelligence, AlienVault OTX, TAXII Feeds


resource "azurerm_log_analytics_workspace" "example" {
  name                = "example-workspace"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  sku                 = "pergb2018"
}

resource "azurerm_log_analytics_solution" "example" {
  solution_name         = "SecurityInsights"
  location              = azurerm_resource_group.example.location
  resource_group_name   = azurerm_resource_group.example.name
  workspace_resource_id = azurerm_log_analytics_workspace.example.id
  workspace_name        = azurerm_log_analytics_workspace.example.name

  plan {
    publisher = "Microsoft"
    product   = "OMSGallery/SecurityInsights"
  }
}

# enables Microsoft Entra ID logging in Sentinel
resource "azurerm_sentinel_data_connector_azure_active_directory" "example" {
  name                       = "example"
  log_analytics_workspace_id = azurerm_sentinel_log_analytics_workspace_onboarding.example.workspace_id
}

# SIEM rule to detect brute force attacks
resource "azurerm_sentinel_alert_rule_scheduled" "brute_force" {
  name                = "Brute Force Login Attempt"
  log_analytics_workspace_id = azurerm_log_analytics_workspace.example.id
  display_name = "value"
  severity            = "High"
  query               = <<-EOT
    SecurityEvent
    | where EventID == 4625
    | summarize count() by Account, bin(TimeGenerated, 5m)
    | where count_ > 5
  EOT
  enabled   = true
}

resource "azurerm_sentinel_metadata" "example" {
  name         = "exampl"
  workspace_id = azurerm_log_analytics_solution.example.workspace_resource_id
  content_id   = azurerm_sentinel_alert_rule_nrt.example.name
  kind         = "AnalyticsRule"
  parent_id    = azurerm_sentinel_alert_rule_nrt.example.id
}


# use Kusto Query Language (KQL) for threat hunting
# detects MFA bypass attempts in Entra
# SigninLogs
# | where ResultType == 50074
# | summarize count() by UserPrincipalName
# | order by count_ desc

# check enabled data connectors
# az sentinel data-connector list --resource-group MyResourceGroup --workspace-name sentinel-workspace --output table

# list active security incidents
# az sentinel incident list --resource-group MyResourceGroup --workspace-name sentinel-workspace --output table

# view security playbook execution logs
# az sentinel automation-rule list --resource-group MyResourceGroup --workspace-name sentinel-workspace --output table
