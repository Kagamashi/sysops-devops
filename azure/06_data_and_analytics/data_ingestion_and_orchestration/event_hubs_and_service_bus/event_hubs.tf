# Azure Event Hubs
# real-time data ingestion service designed to process millions of events per second, enabling streaming and event-driven architectures

# Key features:
#   - handles millions of events per seconds
#   - retains events for up to 7 days for reprocessing
#   - ensures parallel and scalabl event consumption
#   - supports AMQP, Kafka, HTTP, Azure SDKs
#   - works with Stream Analytics, Functions, Databricks.. 

# Core components of Azure Event Hubs:
#   - Event Hub Namespace:	Acts as a container for multiple Event Hubs
#   - Event Hub:	The actual event stream that stores incoming events
#   - Partitions:	Divides event processing for parallel consumption
#   - Producers:	Send events to Event Hub
#   - Consumers:	Read and process events from Event Hub
#   - Capture:	Automatically saves events to Azure Storage or Data Lake


resource "azurerm_eventhub_namespace" "example" {
  name                = "example-namespace"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  sku                 = "Standard"  #  Basic || Standard || Dedicated
  capacity            = 2
}

resource "azurerm_eventhub" "example" {
  name                = "example-eventhub"
  namespace_id        = azurerm_eventhub_namespace.example.id
  partition_count     = 4  # number of partitions for parallel processing
  message_retention   = 7  # retain events for 7 days
}

resource "azurerm_eventhub_authorization_rule" "example" {
  name                = "example-auth-rule"
  namespace_name      = azurerm_eventhub_namespace.example.name
  eventhub_name       = azurerm_eventhub.example.name
  resource_group_name = azurerm_resource_group.example.name
  listen              = true  # allows consumer access
  send                = true  # allows producer access
  manage              = false
}

resource "azurerm_eventhub_capture_description" "example" {
  eventhub_name       = azurerm_eventhub.example.name
  namespace_name      = azurerm_eventhub_namespace.example.name
  resource_group_name = azurerm_resource_group.example.name
  enabled            = true

  destination {
    name               = "EventHubArchive.AzureBlockBlob"
    storage_account_id = azurerm_storage_account.example.id
    blob_container_name = "eventhubcapture"
  }
}
