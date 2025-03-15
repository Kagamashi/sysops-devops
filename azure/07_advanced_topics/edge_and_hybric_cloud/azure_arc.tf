# Azure Arc
# extends Azure management, governance, security to on-premise, multi-cloud and edge environments
# allows organizations to use Azure services and policies across any infrastructure, including AWS, Google Cloud, on-premises data center

#   - unified management from a single control plane
#   - apply Azure policies, RBAC, security to any K8s or VM
#   - deploy Azure SQL, PostgreSQL and other PaaS services on-premises
#   - enabled GitOps, CI/CD, IaC for non-Azure environments

# How Azure Arc works:
#   1️. Install the Azure Arc agent on VMs, Kubernetes clusters, or servers.
#   2️. Azure Arc registers non-Azure resources inside Azure Resource Manager.
#   3️. Manage resources via Azure Portal, CLI, or PowerShell just like native Azure resources.
#   4️. Apply policies, monitoring, security, and automation across hybrid and multi-cloud infrastructure.

# 
resource "azurerm_arc_machine" "example" {
  name                = "example-arcmachine"
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location
  kind                = "SCVMM" # System Center Virtual Machine Manager

  identity {
    type = "SystemAssigned"
  }
}

# installs Azure Monitor Agent on registered VM
resource "azurerm_arc_machine_extension" "example" {
  name           = "example"
  location       = "West Europe"
  arc_machine_id = data.azurerm_arc_machine.example.id
  publisher      = "Microsoft.Azure.Monitor"
  type           = "AzureMonitorLinuxAgent"
}

resource "azurerm_arc_kubernetes_cluster" "example" {
  name                         = "example-akcc"
  resource_group_name          = azurerm_resource_group.example.name
  location                     = "West Europe"
  agent_public_key_certificate = filebase64("testdata/public.cer")

  identity {
    type = "SystemAssigned"
  }
}
