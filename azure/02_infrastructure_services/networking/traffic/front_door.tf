# Global Layer 7 (HTTP/HTTPS) load balancer and CDN service
# global content delivery and application acceleration service that routes and optimizes web traffic using Microsoft's global network
# recommended for global internet-facing applications

# Key features:
#   - Global HTTP/HTTPS Load Balancing
#   - SSL Offloading & HTTPS Redirects
#   - DDoS Protection & WAF
#   - Multi-Region Traffic Management
#   - URL-Based Routing & Path Forwarding 
#   - Private Link Integration

# How it works:
#   1️. User sends request to Azure Front Door
#   2️. Front Door routes traffic to the closest & healthiest backend
#   3️. Optimized & secure global network handles delivery
#   4️. WAF inspects and filters bad requests
#   5️. User gets fast, secure access to the application

# container for AFD configurations
resource "azurerm_cdn_frontdoor_profile" "example" {
  name                = "example-profile"
  resource_group_name = azurerm_resource_group.example.name
  sku_name            = "Standard_AzureFrontDoor"
}

# defines backend group where multiple backends are grouped together
resource "azurerm_cdn_frontdoor_origin_group" "example" {
  name                     = "example-originGroup"
  cdn_frontdoor_profile_id = azurerm_cdn_frontdoor_profile.example.id

  load_balancing {
    additional_latency_in_milliseconds = 0
    sample_size                        = 16
    successful_samples_required        = 3
  }
}

# defines an origin backends (a website, VM, API, App Service)
resource "azurerm_cdn_frontdoor_origin" "example" {
  name                          = "example-origin"
  cdn_frontdoor_origin_group_id = azurerm_cdn_frontdoor_origin_group.example.id
  enabled                       = true

  certificate_name_check_enabled = false

  host_name          = "contoso.com"
  http_port          = 80
  https_port         = 443
  origin_host_header = "www.contoso.com" # expected hostname for backend requests
  priority           = 1
  weight             = 1
}

# serves as an entry point for user requests
# users access AFD via this endpoint, and requests are routed based on defined rules
resource "azurerm_cdn_frontdoor_endpoint" "example" {
  name                     = "example-endpoint"
  cdn_frontdoor_profile_id = azurerm_cdn_frontdoor_profile.example.id
}

# set of rules applied to requests (header modifications, redirects etc.)
resource "azurerm_cdn_frontdoor_rule_set" "example" {
  name                     = "ExampleRuleSet"
  cdn_frontdoor_profile_id = azurerm_cdn_frontdoor_profile.example.id
}

resource "azurerm_cdn_frontdoor_custom_domain" "contoso" {
  name                     = "contoso-custom-domain"
  cdn_frontdoor_profile_id = azurerm_cdn_frontdoor_profile.example.id
  dns_zone_id              = azurerm_dns_zone.example.id
  host_name                = join(".", ["contoso", azurerm_dns_zone.example.name])

  tls {
    certificate_type    = "ManagedCertificate" # uses Azure-managed SSL certificates, which automatically renew and are free
    # minimum_tls_version = "TLS12" # enforces HTTPS
  }
}

resource "azurerm_cdn_frontdoor_custom_domain" "fabrikam" {
  name                     = "fabrikam-custom-domain"
  cdn_frontdoor_profile_id = azurerm_cdn_frontdoor_profile.example.id
  dns_zone_id              = azurerm_dns_zone.example.id
  host_name                = join(".", ["fabrikam", azurerm_dns_zone.example.name])

  tls {
    certificate_type    = "ManagedCertificate"
    # minimum_tls_version = "TLS12"
  }
}

# routes traffic through AFD to the backend
resource "azurerm_cdn_frontdoor_route" "example" {
  name                          = "example-route"
  cdn_frontdoor_endpoint_id     = azurerm_cdn_frontdoor_endpoint.example.id
  cdn_frontdoor_origin_group_id = azurerm_cdn_frontdoor_origin_group.example.id
  cdn_frontdoor_origin_ids      = [azurerm_cdn_frontdoor_origin.example.id]
  cdn_frontdoor_rule_set_ids    = [azurerm_cdn_frontdoor_rule_set.example.id]
  enabled                       = true

  forwarding_protocol    = "HttpsOnly"
  https_redirect_enabled = true # redirects HTTP -> HTTPS
  patterns_to_match      = ["/*"]
  supported_protocols    = ["Http", "Https"]

  cdn_frontdoor_custom_domain_ids = [azurerm_cdn_frontdoor_custom_domain.contoso.id, azurerm_cdn_frontdoor_custom_domain.fabrikam.id] # associate custom domains with this route
  link_to_default_domain          = false

  cache { # caches static content to improve performance
    query_string_caching_behavior = "IgnoreSpecifiedQueryStrings"
    query_strings                 = ["account", "settings"]
    compression_enabled           = true
    content_types_to_compress     = ["text/html", "text/javascript", "text/xml"]
  }
}

# links custom domains to Front Door route
resource "azurerm_cdn_frontdoor_custom_domain_association" "contoso" {
  cdn_frontdoor_custom_domain_id = azurerm_cdn_frontdoor_custom_domain.contoso.id
  cdn_frontdoor_route_ids        = [azurerm_cdn_frontdoor_route.example.id]
}

resource "azurerm_cdn_frontdoor_custom_domain_association" "fabrikam" {
  cdn_frontdoor_custom_domain_id = azurerm_cdn_frontdoor_custom_domain.fabrikam.id
  cdn_frontdoor_route_ids        = [azurerm_cdn_frontdoor_route.example.id]
}

# Web Application Firewall (WAF)
resource "azurerm_cdn_frontdoor_firewall_policy" "example" {
  name                              = "exampleWAF"
  resource_group_name               = azurerm_resource_group.example.name
  sku_name                          = azurerm_cdn_frontdoor_profile.example.sku_name
  enabled                           = true
  mode                              = "Prevention"
  redirect_url                      = "https://www.contoso.com"
  custom_block_response_status_code = 403
  custom_block_response_body        = "PGh0bWw+CjxoZWFkZXI+PHRpdGxlPkhlbGxvPC90aXRsZT48L2hlYWRlcj4KPGJvZHk+CkhlbGxvIHdvcmxkCjwvYm9keT4KPC9odG1sPg=="

  custom_rule {
    name                           = "Rule1"
    enabled                        = true
    priority                       = 1
    rate_limit_duration_in_minutes = 1
    rate_limit_threshold           = 10
    type                           = "MatchRule"
    action                         = "Block"

    match_condition {
      match_variable     = "RemoteAddr"
      operator           = "IPMatch"
      negation_condition = false
      match_values       = ["192.168.1.0/24", "10.0.1.0/24"]
    }
  }
}

resource "azurerm_cdn_frontdoor_security_policy" "example" {
  name                     = "Example-Security-Policy"
  cdn_frontdoor_profile_id = azurerm_cdn_frontdoor_profile.example.id

  security_policies {
    firewall {
      cdn_frontdoor_firewall_policy_id = azurerm_cdn_frontdoor_firewall_policy.example.id

      association {
        domain {
          cdn_frontdoor_domain_id = azurerm_cdn_frontdoor_custom_domain.example.id
        }
        patterns_to_match = ["/*"]
      }
    }
  }
}
