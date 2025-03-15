# Azure Table Storage

# A lightweight NoSQL key-value store for structured data.
# Best for: Logging, telemetry, session storage
# Features: Low-cost, scalable, schema-less

resource "azurerm_storage_account" "example" {
  name                     = "examplestoragetable"
  resource_group_name      = azurerm_resource_group.example.name
  location                 = azurerm_resource_group.example.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  account_kind             = "StorageV2"  # Required for Table Storage support (it's default)

  network_rules {
    default_action = "Deny"
    ip_rules       = ["10.10.10.0/24"]
    bypass         = ["AzureServices"]
  }
}

resource "azurerm_storage_table" "example" {
  name                 = "examplestorage"
  storage_account_name = azurerm_storage_account.example.name
}

resource "azurerm_storage_table_entity" "example" {
  storage_table_id = azurerm_storage_table.example.id

  partition_key = "examplepartition"
  row_key       = "examplerow"

  entity = {
    example = "example"
  }
}

resource "azurerm_private_endpoint" "example" {
  name                = "table-private-endpoint"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  subnet_id           = azurerm_subnet.example.id

  private_service_connection {
    name                           = "privatelink-tablestorage"
    private_connection_resource_id = azurerm_storage_account.example.id
    subresource_names              = ["table"]  # Private endpoint for Table Storage
    is_manual_connection           = false
  }
}
