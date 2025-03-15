#!/bin/bash

# Variables
ACCOUNT_NAME="storageaccountname"
CONTAINER_NAME="containername"
RESOURCE_GROUP="resourcegroupname" # Specify the resource group of the storage account
SUBSCRIPTION_ID="subscription_id" # Specify the subscription ID

# Authenticate with Azure and set the subscription
az account set --subscription "$SUBSCRIPTION_ID"

# Retrieve the storage account key dynamically
echo "Fetching storage account key for: $ACCOUNT_NAME..."
ACCOUNT_KEY=$(az storage account keys list \
  --resource-group "$RESOURCE_GROUP" \
  --account-name "$ACCOUNT_NAME" \
  --query "[0].value" \
  -o tsv)

if [ -z "$ACCOUNT_KEY" ]; then
  echo "Failed to retrieve storage account key for: $ACCOUNT_NAME"
  exit 1
fi

# Set the connection string dynamically
export AZURE_STORAGE_CONNECTION_STRING="DefaultEndpointsProtocol=https;AccountName=$ACCOUNT_NAME;AccountKey=$ACCOUNT_KEY;EndpointSuffix=core.windows.net"

# Get all blobs in the container
echo "Fetching blobs from container: $CONTAINER_NAME..."
BLOBS=$(az storage blob list \
  --container-name "$CONTAINER_NAME" \
  --account-name "$ACCOUNT_NAME" \
  --query "[].name" \
  -o tsv)

if [ -z "$BLOBS" ]; then
  echo "No blobs found in container: $CONTAINER_NAME"
  exit 0
fi

# Attempt to break leases on all blobs
for BLOB_NAME in $BLOBS; do
  echo "Attempting to break lease for blob: $BLOB_NAME..."
  az storage blob lease break \
    --blob-name "$BLOB_NAME" \
    --container-name "$CONTAINER_NAME" \
    --account-name "$ACCOUNT_NAME" \
    --connection-string "$AZURE_STORAGE_CONNECTION_STRING" --output json || echo "No active lease on blob: $BLOB_NAME"
done

echo "Lease check and break process completed."
