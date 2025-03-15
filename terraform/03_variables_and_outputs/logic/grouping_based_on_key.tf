# simulates creation of multiple Azure Container Registry private endpoints
variable endpoints {
  type = map
  default = {
    "registry" = {
      custom_dns_configs = [
        {
          fqdn = "something.westeurope.data.azurecr.io"
          ip_addresses = ["1.1.1.1",]
        },
        {
          fqdn         = "something.azurecr.io"
          ip_addresses = ["1.1.1.2",]
        }
      ]
    },
    "registry2" = {
      custom_dns_configs = [
        {
          fqdn = "something.westeurope.data.azurecr.io"
          ip_addresses = ["1.1.2.1",]
        },
        {
          fqdn = "something.azurecr.io"
          ip_addresses = ["1.1.2.2",]
        },
      ]
    },
    #...
    # "registryN" = {...}
  }
}

# flatten collapses nested lists into a single list of elements and removes any null values
output "result" {
  value = {
    for cdc in flatten([for pe in values(var.endpoints): pe.custom_dns_configs]):  # iterates over all private endpoints (pe) and extracts their custom_dns_configs
      cdc.fqdn => flatten([   # iterates over all custom_dns_configs (cdc) and extracts their fqdn and ip_addresses
        lookup(cdc, "ip_addresses", []) # uses lookup to safely extract the ip_addresses key from each custom_dns_config; flatten ensures all IPs are in a single flat list for each FQDN.
      ])
  }
}

# result = {
#   "something.westeurope.data.azurecr.io" = [
#     "1.1.1.1",
#     "1.1.2.1",
#   ]
#   "something.azurecr.io" = [
#     "1.1.1.2",
#     "1.1.2.2",
#   ]
# }