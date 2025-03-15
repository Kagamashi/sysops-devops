'''
automates azure services using Python

'pip install azure-mgmt-resource azure-identity'

authenticating:
- managed identity
- service principal
- azure CLI authentication 

DefaultAzureCredential() automatically pick best method
'''

from azure.identity import DefaultAzureCredential # type: ignore
from azure.mgmt.resource import ResourceManagementClient # type: ignore

# Authenticate using Azure CLI or Managed Identity
credential = DefaultAzureCredential()

# Define subscription ID
subscription_id = "your-subscription-id"

# Create a Resource Management Client
resource_client = ResourceManagementClient(credential, subscription_id)

# List resource groups
for group in resource_client.resource_groups.list():
    print(f"Resource Group: {group.name}")
