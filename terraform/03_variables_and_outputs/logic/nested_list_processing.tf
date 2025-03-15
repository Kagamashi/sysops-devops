variable zones {
  type = map(object({
    privatelink_names = list(string)
    records = object({
      a = list(object({
        name    = string
        records = list(string)
        ttl     = number
      }))
      cname = list(object({
        name   = string
        record = string
        ttl    = number
      }))
    })
  }))
  
  default = {
    "privatelink.westeurope.azmk8s.io" = { # AKS
      privatelink_names = ["management"]
      records = {
        a = [
          {name = "aks-nodepool1", records = ["10.0.0.1"], ttl = 300},
        ]
        cname = []
      }
    }
    "privatelink.azurecr.io" = {
      privatelink_names = ["registry"] # ACR
      records = {
        a = [
          {name = "acr-prod", records = ["10.0.1.1"], ttl = 3600},
        ]
        cname = [
          {name = "acr-prod-cname", record = "acr.example.com", ttl = 3600},
        ]
      }
    }
    "privatelink.database.windows.net" = {
      privatelink_names = ["sqlServer"]
      records = {
        a = [
          {name = "sql-dev", records = ["10.1.1.1"], ttl = 300},
          {name = "sql-prod", records = ["10.1.1.2"], ttl = 300},
        ]
        cname = [
          {name = "sql-alias", record = "sql.example.com", ttl = 300},
        ]
      }
    }
  }
}

resource "azurerm_private_dns_a_record" "privatelink_records" {
  for_each = {for i in flatten([for k,v in var.zones: [for r in v.records.a: {  # flatten is used to collapse nested lists into a single list of elements and remove any null values
      name = r.name
      records = r.records
      ttl = r.ttl
      tags = var.tags
      fqdn = "${r.name}.${k}" # fqdn is constructed by concatenating the record name with the zone name
      zone_name = k
    }]
  ]): i.fqdn => i} # the key for the map is the fqdn

  name                = each.value.name
  zone_name           = azurerm_private_dns_zone.zone[each.value.zone_name].name
  resource_group_name = azurerm_private_dns_zone.zone[each.value.zone_name].resource_group_name
  ttl                 = each.value.ttl
  records             = each.value.records

  tags                = each.value.tags
}
# first record:
# azurerm_private_dns_a_record.privatelink_records["aks-nodepool1.privatelink.westeurope.azmk8s.io"] = {
#   name                = "aks-nodepool1"
#   zone_name           = "privatelink.westeurope.azmk8s.io"
#   resource_group_name = "example-rg"
#   ttl                 = 300
#   records             = ["10.0.0.1"]
#   tags                = {
#     environment = "dev"
#     team        = "platform"
#   }
# }


resource "azurerm_private_dns_cname_record" "privatelink_records" {
  for_each = {for i in flatten([for k,v in var.zones: [for r in v.records.cname: {
      name = r.name
      record = r.record
      ttl = r.ttl
      tags = var.tags
      fqdn = "${r.name}.${k}"
      zone_name = k
    }]
  ]): i.fqdn => i}

  name                = each.value.name
  zone_name           = azurerm_private_dns_zone.zone[each.value.zone_name].name
  resource_group_name = azurerm_private_dns_zone.zone[each.value.zone_name].resource_group_name
  ttl                 = each.value.ttl
  record              = each.value.record

  tags                = each.value.tags
}

variable tags {}
