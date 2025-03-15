# Layer 7 (HTTP/HTTPS) load balancer
# web traffic manager that routes and balances HTTP/HTTPS requests across a pol of web servers
# supports VMs, VMSSs, Azure App Service, on-premises server

# Features:
#   - session stickiness: ensures client requests in a session go to the same backend server
#   - Web Application Firewall (WAF)
#       protects against SQL injection, XSS, DDoS attacks
#       supports OWASP Core Rule Set (CRS)
#       runs in detection or prevention mode
#  - SSL termination and end-to-end SSL
#  - autoscaling & zone redundancy
#  - supports HTTP, HTTPS, HTTP/2 and WebSocket protocols

# Routing methods:
#   - path-based routing: routes different URL paths to specific backend pools
#   - multiple-site routing: supports multiple web apps on the same Application Gateway
# additional features:
#   - redirection: redirects HTTP to HTTPS
#   - rewrite HTTP headers: modify request/response headers
#   - custom error pages: display user-defined error pages instead of default messages


resource "azurerm_public_ip" "example" {
  name                = "example-pip"
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location
  allocation_method   = "Static"
}

# since these variables are re-used - a locals block makes this more maintainable
locals {
  backend_address_pool_name      = "${azurerm_virtual_network.example.name}-beap"
  frontend_port_name             = "${azurerm_virtual_network.example.name}-feport"
  frontend_ip_configuration_name = "${azurerm_virtual_network.example.name}-feip"
  http_setting_name              = "${azurerm_virtual_network.example.name}-be-htst"
  listener_name                  = "${azurerm_virtual_network.example.name}-httplstn"
  request_routing_rule_name      = "${azurerm_virtual_network.example.name}-rqrt"
  redirect_configuration_name    = "${azurerm_virtual_network.example.name}-rdrcfg"
}

resource "azurerm_application_gateway" "network" {
  name                = "example-appgateway"
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location

  sku {
    name     = "Standard_v2" # || Basic || WAF_v2
    tier     = "Standard_v2" # WAF_v2 sku enables Web Application Firewall (WAF)
    capacity = 2
  }

  autoscale_configuration {
    min_capacity = 2
    max_capacity = 5
  }

  gateway_ip_configuration {
    name      = "my-gateway-ip-configuration"
    subnet_id = azurerm_subnet.example.id
  }

  frontend_port {
    name = local.frontend_port_name
    port = 80
  }

  frontend_ip_configuration {
    name                 = local.frontend_ip_configuration_name
    public_ip_address_id = azurerm_public_ip.example.id
  }

  backend_address_pool { # targets VMs or App Services
    name = local.backend_address_pool_name
  }

  backend_http_settings {
    name                  = local.http_setting_name
    cookie_based_affinity = "Disabled"
    path                  = "/path1/"
    port                  = 80
    protocol              = "Http"
    request_timeout       = 60
  }

  http_listener { # handles incoming requests
    name                           = local.listener_name
    frontend_ip_configuration_name = local.frontend_ip_configuration_name
    frontend_port_name             = local.frontend_port_name
    protocol                       = "Http"
  }

  request_routing_rule { # bind listeners to backend pools
    name                       = local.request_routing_rule_name
    priority                   = 9
    rule_type                  = "Basic"
    http_listener_name         = local.listener_name
    backend_address_pool_name  = local.backend_address_pool_name
    backend_http_settings_name = local.http_setting_name
  }

  # Web Application Firewall (WAF) configuration enabled in Prevention mode
  waf_configuration {
    enabled          = true
    firewall_mode    = "Prevention"  # Blocks malicious traffic
    rule_set_type    = "OWASP"
    rule_set_version = "3.2"  # OWASP Core Rule Set version
    # policy_id = azurerm_web_application_firewall_policy.waf.id    # reference to apply WAF policies and rules
  }
}
