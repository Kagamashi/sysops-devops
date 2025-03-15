
# A "for" expression creates a complex type value by transforming another complex type value.

# Loop over a list and output a map
# {for <ITEM> in <LIST> : <OUTPUT_KEY> => <OUTPUT_VALUE>}
variable "resource_names" {
  type    = list(string)
  default = ["app", "db", "cache"]
}

output "resource_name_map" {
  value = {for name in var.resource_names : name => upper(name)}
}

# {
#   "app"   = "APP"
#   "db"    = "DB"
#   "cache" = "CACHE"
# }



# Loop over a map and output a map
# {for <KEY>, <VALUE> in <MAP> : <OUTPUT_KEY> => <OUTPUT_VALUE>}
variable "resource_types" {
  type = map(string)
  default = {
    "web"  = "B1s"
    "app"  = "B2s"
    "db"   = "B2ms"
  }
}

output "transformed_resource_types" {
  value = {for type, size in var.resource_types : type => "Standard_${size}"}
}

# {
#   "web"  = "Standard_B1s"
#   "app"  = "Standard_B2s"
#   "db"   = "Standard_B2ms"
# }


# Loop over a list to produce a transformed list
# [for <ITEM> in <LIST> : <OUTPUT>]
variable "resource_groups" {
  type    = list(string)
  default = ["rg-dev", "rg-test", "rg-prod"]
}

output "uppercase_resource_groups" {
  value = [for rg in var.resource_groups : upper(rg)]
}

# ["RG-DEV", "RG-TEST", "RG-PROD"]


# Example: Filter elements with a condition
variable "resource_types" {
  type = map(string)
  default = {
    "web"  = "B1s"
    "app"  = "B2s"
    "db"   = "B2ms"
  }
}

output "filtered_resource_types" {
  value = {for type, size in var.resource_types : type => size if size == "B2s"}
}

# {
#   "app" = "B2s"
# }
