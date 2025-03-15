# Azure Kubernetes Service
# managed Kubernetes service, abstracts complexity of K8s infrastructure

# Deployment models:
#   - Single-region Cluster
#   - Multi-region Cluster - disaster recovery
#   - Private Cluster - API server only accessible via Private Endpoint
#   - Hybrid/Multi-cloud - managed via Azure Arc

# High Availability:
#   - Node Pool scaling - scale out VM instances for worker nodes
#   - Pod autoscaling - Horizontal Pod Autoscaler adjusts replica counts
#   - Cluster Autoscaler - adds or removes VM instances dynamically

# Networking:
#   - Azure CNI (advanced) - assign real IPs from VNET to pods
#   - Kubenet (basic) - uses NAT for IP allocation (good for small clusters)
#   - BYO VNET (Bring Your Own VNET) - full network control

resource "azurerm_kubernetes_cluster" "example" {
  name                = "aks-cluster"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  dns_prefix          = "aks-example"
  
  identity {
    type = "SystemAssigned"
  }

  role_based_access_control_enabled = true
  private_cluster_enabled = true

  network_profile {
    network_plugin    = "azure"   # Azure CNI (assigns IPs from VNET)
    network_policy    = "calico"  # Calico for advanced Network Policies
    load_balancer_sku = "standard"
  }

  default_node_pool {
    name                = "nodepool1"
    node_count          = 3
    vm_size             = "Standard_D2s_v3"
    vnet_subnet_id      = azurerm_subnet.aks_subnet.id
    min_count           = 2
    max_count           = 5
  }

  oms_agent {
    log_analytics_workspace_id = azurerm_log_analytics_workspace.example.id
  }
}

resource "azurerm_kubernetes_cluster_node_pool" "gpu" {
  name                  = "gpunodes"
  kubernetes_cluster_id = azurerm_kubernetes_cluster.example.id
  vm_size               = "Standard_NC6s_v3" # GPU-optimized
  node_count            = 1
  min_count             = 1
  max_count             = 3
  mode                  = "User" # must be set to "User" for additional pools
}

