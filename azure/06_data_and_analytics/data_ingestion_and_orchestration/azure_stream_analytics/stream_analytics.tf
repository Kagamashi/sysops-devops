# Azure Stream Analytics (ASA)
# real-time event processing service designed to analyze and process streaming data from IoT devices, logs, sensors, social media feeds, and applications
# provides low latency insights using SQL-like queries and integrates with Azure Event Hub, IoT Hub, Blob Storage

# Key features:
#   - Real-time Analytics: processes data on the fly, detecting patterns, anomalies and trends
#   - SQL-based Query Language: uses T-SQL like syntax to transform, aggregate and analyze data
#   - Multiple Input Sources: works with Event Hub, IoT Hub, Blob Storage..
#   - Output to Various Destinations: sends results to Azure SQL DB, Cosmos DB, Power BI.. 
#   - Supports ML models for advanced analytics

# Core components of Azure Stream Analytics:
#   - Input:	Defines the data source (Event Hub, IoT Hub, Blob Storage)
#   - Query:	Uses SQL-like syntax to transform & process data
#   - Output:	Sends processed data to SQL, CosmosDB, Blob, Power BI, etc.
#   - Streaming Job:	Executes real-time processing logic
#   - Scale Units:	Defines compute resources for the job


resource "azurerm_stream_analytics_job" "example" {
  name                                     = "example-job"
  resource_group_name                      = azurerm_resource_group.example.name
  location                                 = azurerm_resource_group.example.location
  compatibility_level                      = "1.2"
  data_locale                              = "en-GB"
  events_late_arrival_max_delay_in_seconds = 60
  events_out_of_order_max_delay_in_seconds = 50
  events_out_of_order_policy               = "Adjust"
  output_error_policy                      = "Drop"
  streaming_units                          = 3
  sku_name                                 = "StandardV2"

  tags = {
    environment = "Example"
  }

  transformation_query = <<QUERY
    SELECT *
    INTO [YourOutputAlias]
    FROM [YourInputAlias]
QUERY
}

# INPUT: Event Hub
resource "azurerm_stream_analytics_stream_input_eventhub" "example" {
  name                         = "eventhub-stream-input"
  stream_analytics_job_name    = data.azurerm_stream_analytics_job.example.name
  resource_group_name          = data.azurerm_stream_analytics_job.example.resource_group_name
  eventhub_consumer_group_name = azurerm_eventhub_consumer_group.example.name
  eventhub_name                = azurerm_eventhub.example.name
  servicebus_namespace         = azurerm_eventhub_namespace.example.name
  shared_access_policy_key     = azurerm_eventhub_namespace.example.default_primary_key
  shared_access_policy_name    = "RootManageSharedAccessKey"

  serialization {
    type     = "Json"
    encoding = "UTF8"
  }
}

# OUTPUT: Azure SQL Database
resource "azurerm_stream_analytics_output_mssql" "example" {
  name                      = "example-output-sql"
  stream_analytics_job_name = data.azurerm_stream_analytics_job.example.name
  resource_group_name       = data.azurerm_stream_analytics_job.example.resource_group_name

  server   = azurerm_sql_server.example.fully_qualified_domain_name
  user     = azurerm_sql_server.example.administrator_login
  password = azurerm_sql_server.example.administrator_login_password
  database = azurerm_sql_database.example.name
  table    = "ExampleTable"
}
