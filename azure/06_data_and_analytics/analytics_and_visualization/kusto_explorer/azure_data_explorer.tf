# Azure Data Explorer

# A real-time data analytics service optimized for log and telemetry analysis.
# Best for: IoT, real-time monitoring
# Features: Interactive queries, AI-powered insights

resource "azurerm_kusto_cluster" "cluster" {
  name                = "kustocluster"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name

  sku {
    name     = "Standard_D13_v2"
    capacity = 2
  }
}

resource "azurerm_kusto_database" "database" {
  name                = "my-kusto-database"
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location
  cluster_name        = azurerm_kusto_cluster.cluster.name

  hot_cache_period   = "P7D"
  soft_delete_period = "P31D"

  # prevent the possibility of accidental data loss
  lifecycle {
    prevent_destroy = true
  }
}
