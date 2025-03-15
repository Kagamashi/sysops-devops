# Application Security Group [ASG]
# provide application-centric method for grouping VMs

#   - simplifies IP-based rules - no need to specify IP addresses/subnets
#   - dynamically applies new rules to all VMs in the ASG
#   - create NSG rules that reference ASG as source/destination

# Example:
# WebASG for web servers
# DBASG for database servers
#   - Allow traffic from Internet → WebASG on ports 80/443 (priority 100)
#   - Allow traffic from WebASG → DBASG on port 1433 (priority 110)
#   - Deny traffic from anywhere → DBASG on port 1433 (priority 120)
# Only web servers can reach the databases

resource "azurerm_application_security_group" "example" {
  name                = "tf-appsecuritygroup"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name

  tags = {
    Hello = "World"
  }
}
