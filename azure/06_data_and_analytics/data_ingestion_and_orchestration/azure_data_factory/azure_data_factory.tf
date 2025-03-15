# Azure Data Factory (ADF)
# cloud based ETL (Extract, Transform, Load) and data integration service that orchestrates data workflows across multiple sources and destinations

# Key features:
#   - Data Ingestion: supports over 90+ data sources (Azure SQL, Blob Storage, On-prem databases etc.)
#   - Data Transformation: uses Data Flows, Azure Databricks, Synapse, HDInsights
#   - Data Movement: moves data between cloud and on-premise using Integration Runtimes
#   - Data Orchestration: automates complex workflows using Pipelines & Triggers

# Core components of Azure Data Factory:
#   - Pipeline: A logical grouping of activities (ETL process)
#   - Activity: A single step in a pipeline (e.g., copy, transform, store)
#   - Dataset: Represents the source or destination data
#   - Linked Service: Connection string to external data sources
#   - Trigger: Automates pipeline execution (e.g., schedule-based, event-driven)
#   - Integration Runtime: Executes pipeline workloads (cloud-based or self-hosted)

# LINKED SERVICE: connect ADF to Azure Blob Storage
resource "azurerm_data_factory_linked_service_azure_blob_storage" "example" {
  name            = "example-blob-storage"
  data_factory_id = azurerm_data_factory.example.id
  connection_string = "DefaultEndpointsProtocol=https;AccountName=storageaccount;AccountKey=key;EndpointSuffix=core.windows.net"
}

# DATASET: define source storage
resource "azurerm_data_factory_dataset_azure_blob" "example" {
  name                = "example"
  data_factory_id     = azurerm_data_factory.example.id
  linked_service_name = azurerm_data_factory_linked_service_azure_blob_storage.example.name

  path     = "foo"
  filename = "bar.png"
}

# PIPELINE: copy data from source to destination
resource "azurerm_data_factory_pipeline" "example" {
  name            = "example-pipeline"
  data_factory_id = azurerm_data_factory.example.id
  activities_json = jsonencode([
    {
      "name": "CopyDataActivity",
      "type": "Copy",
      "inputs": [{ "referenceName": "example-dataset", "type": "DatasetReference" }],
      "outputs": [{ "referenceName": "example-dataset", "type": "DatasetReference" }],
      "typeProperties": {
        "source": {
          "type": "BlobSource"
        },
        "sink": {
          "type": "BlobSink"
        }
      }
    }
  ])
}

# TRIGGER: automate pipeline execution
resource "azurerm_data_factory_trigger_schedule" "example" {
  name            = "example"
  data_factory_id = azurerm_data_factory.example.id
  pipeline_name   = azurerm_data_factory_pipeline.example.name

  interval  = 5
  frequency = "Day"
}

# list pipelines
# az datafactory pipeline list --resource-group rg-datafactory --factory-name example-adf --output table

# run pipeline manually
# az datafactory pipeline create-run --resource-group rg-datafactory --factory-name example-adf --name example-pipeline

# check pipeline runs
# az datafactory pipeline-run query-by-factory --resource-group rg-datafactory --factory-name example-adf --output table
