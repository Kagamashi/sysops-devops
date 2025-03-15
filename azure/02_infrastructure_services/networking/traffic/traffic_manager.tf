# DNS-based traffic routing.
# distributes traffic globally across regions based on performance, priority, weight or geographic location.
# provides DNS resolution, does NOT proxy traffic
# traffic manager checks endpoint health before routing traffic using health probes

# Key features:
#   - global load balancing: distributes traffic across multiple regions
#   - failover & high availability: redirects traffic to healthy endpoints
#   - multi-cloud & hybrid support: works with on-premises, AWS and GCP
#   - custom traffic routing: uses multiple routing policies like performance, priority, weighted, geographic

# How it works:
#   1️. User sends a DNS request to access an application.
#   2️. Traffic Manager evaluates routing rules and selects the best endpoint.
#   3️. Traffic Manager returns the IP address of the selected endpoint.
#   4️. User's browser connects directly to the endpoint.

# Routing methods:
#   PRIORITY (failover scenarios): directs all traffic to a primary endpoint unless it fails
#   WEIGHTED (A/B testing, gradual rollouts): distributes traffic based on predefined weights
#   PERFORMANCE: routes users to the closest endpoint (lowest latency)
#   GEOGRAPHIC (GDPR compliance): routes traffic based on user's geographic location
#   MULTIVALUE(HA DNS): returns all healthy endpoints
#   SUBNET: routes based on a mapping of sets of end-user IP address ranges




resource "azurerm_traffic_manager_profile" "example" {
  name                   = "traffic_manager"
  resource_group_name    = azurerm_resource_group.example.name
  traffic_routing_method = "Weighted"

  dns_config {
    relative_name = "myapp"  # creates "myapp.trafficmanager.net"
    ttl           = 30 
  }

  monitor_config {
    protocol                     = "HTTPS"
    port                         = 443
    path                         = "/healthcheck"
    interval_in_seconds          = 30
    timeout_in_seconds           = 10
    tolerated_number_of_failures = 3
  }
}

# azureEndpoints
# used for Azure services, automatically detects service health
resource "azurerm_traffic_manager_endpoint" "azure" {
  name                = "azure-endpoint"
  profile_id          = azurerm_traffic_manager_profile.example.id
  type                = "azureEndpoints"
  target_resource_id  = azurerm_public_ip.eastus.id # routes traffic to Azure Public IP
  priority            = 1
}

# externalEndpoints
# non-Azure services (on-prem, AWS, GCP, or external app), requires manually configured IP or FQDN
resource "azurerm_traffic_manager_endpoint" "external" {
  name               = "external-endpoint"
  profile_id         = azurerm_traffic_manager_profile.example.id
  type               = "externalEndpoints"
  target             = "example.com"  # resolves via DNS but does not manage it
  priority           = 2
}

# nestedEndpoints
# routes traffic to another Traffic Manager profile instead of direct endpoint
resource "azurerm_traffic_manager_endpoint" "nested" {
  name                = "nested-endpoint"
  profile_id          = azurerm_traffic_manager_profile.global.id # From Global TM to Regional TM
  type                = "nestedEndpoints"
  target_resource_id  = azurerm_traffic_manager_profile.europe.id  # Regional TM Profile
  minimum_child_endpoints = 1
}
