# Protects web apps from common threats like SQL injection or XSS.
# Available with Azure Application Gateway or Azure Front Door.

# AGW + WAF configuration
#   /networking/traffic_mgmt/app_gateway.tf

# WAF Policies:
#   - when we want to apply the same security settings to multiple AGWs, Front Doors or Azure CDN
#   - centralized control and easier management
#   - Azure Security Center integration and advanced reporting

resource "azurerm_web_application_firewall_policy" "example" {
  name                = "example-wafpolicy"
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location

  policy_settings {
    enabled                     = true
    mode                        = "Prevention" # actively blocks attacks
    request_body_check          = true
    file_upload_limit_in_mb     = 100
    max_request_body_size_in_kb = 128
  }

  managed_rules {
    exclusion {
      match_variable          = "RequestHeaderNames"
      selector                = "x-company-secret-header" # ignore this header in WAF checks
      selector_match_operator = "Equals"
    }
    exclusion {
      match_variable          = "RequestCookieNames"
      selector                = "too-tasty"
      selector_match_operator = "EndsWith"
    }
    exclusion { # avoid blocking requests where user_id=12345 is flagged as SQL Injection
      match_variable          = "QueryStringArgNames"
      selector_match_operator = "Equals"
      selector                = "user_id"
    }

    managed_rule_set {
      type    = "OWASP"
      version = "3.2"

      # exclude specific OWASP rule IDs
      rule_group_override {
        rule_group_name = "REQUEST-920-PROTOCOL-ENFORCEMENT"
        rule {
          id      = "920300"
          enabled = true
          action  = "Log"
        }

        rule {
          id      = "920440"
          enabled = true
          action  = "Block"
        }
      }

      rule_group_override {
        rule_group_name = "SQLI"  # SQL Injection Rule Group
        rule {
          id      = "942100"  # SQL Injection rule causing false positives
          enabled = false  # Disable only this rule
        }
      }
    }
  }

  # Block Specific IPs
  custom_rules {
    name      = "block-malicious-ips"
    priority  = 1
    rule_type = "MatchRule"
    action    = "Block"

    match_conditions {
      match_variables {
        variable_name = "RemoteAddr"
      }
      operator      = "IPMatch"
      match_values  = ["192.168.1.1", "10.0.0.5"] # Add more malicious IPs here
    }
  }

  # Block Requests from Certain Countries (Geolocation)
  custom_rules {
    name      = "block-country-access"
    priority  = 2
    rule_type = "MatchRule"
    action    = "Block"

    match_conditions {
      match_variables {
        variable_name = "ClientGeoLocation"
      }
      operator      = "GeoMatch"
      match_values  = ["CN", "RU", "KP"] # Block China, Russia, North Korea
    }
  }

  # Block SQL Injection Attempts
  custom_rules {
    name      = "block-sql-injection"
    priority  = 3
    rule_type = "MatchRule"
    action    = "Block"

    match_conditions {
      match_variables {
        variable_name = "RequestUri"
      }
      operator      = "Contains"
      match_values  = ["UNION", "SELECT", "DROP", "INSERT", "DELETE"]
    }
  }

  # Rate Limit Requests (Prevent DDoS)
  custom_rules {
    name      = "rate-limit-requests"
    priority  = 4
    rule_type = "RateLimitRule"
    action    = "Block"

    match_conditions {
      match_variables {
        variable_name = "RemoteAddr"
      }
      operator      = "IPMatch"
      match_values  = ["*"] # Apply to all IPs
    }

    rate_limit_threshold = 100  # Max 100 requests per minute
  }
}

# WAF Policy is referenced in waf_configuration section of application_gateway resource

# resource "azurerm_application_gateway" "example" {
#   ...
#   waf_configuration {
#     firewall_mode = "Prevention"
#     policy_id     = azurerm_web_application_firewall_policy.example.id !!!
#   }
# }
