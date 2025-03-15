# Azure Cosmos DB

# A globally distributed NoSQL database with multi-model support.

# Best for: Web apps, IoT, real-time applications
# Models Supported: Document (MongoDB API), Graph (Gremlin), Column-family (Cassandra API), Table (Table API)
# Features: Global distribution, SLA-backed performance, low-latency

data "azurerm_cosmosdb_account" "example" {
  name                = "tfex-cosmosdb-account"
  resource_group_name = "tfex-cosmosdb-account-rg"
}

resource "azurerm_cosmosdb_sql_database" "example" {
  name                = "example-acsd"
  resource_group_name = data.azurerm_cosmosdb_account.example.resource_group_name
  account_name        = data.azurerm_cosmosdb_account.example.name
}

resource "azurerm_cosmosdb_sql_container" "example" {
  name                  = "example-container"
  resource_group_name   = data.azurerm_cosmosdb_account.example.resource_group_name
  account_name          = data.azurerm_cosmosdb_account.example.name
  database_name         = azurerm_cosmosdb_sql_database.example.name
  partition_key_paths   = ["/definition/id"]
  partition_key_version = 1
  throughput            = 400

  indexing_policy {
    indexing_mode = "consistent"

    included_path {
      path = "/*"
    }

    included_path {
      path = "/included/?"
    }

    excluded_path {
      path = "/excluded/?"
    }
  }

  unique_key {
    paths = ["/definition/idlong", "/definition/idshort"]
  }
}
