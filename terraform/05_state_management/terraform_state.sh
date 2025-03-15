
# manages the state file, allowing inspection and modification of resources

terraform state

list    # lists resources in the state
show    # shows details of a specific resource
rm      # removes a resource from the state
pull > terraform.tfstate
push terraform.tfstate

jq . terraform.tfstate      # validate JSON integrity
