# Private Link Service

# Used when we build our own hosted service in Azure and want to connect to them privately from our VNets
#   - Private Endpoints is the core service behind Private Link

resource "azurerm_public_ip" "example" {
  name                = "example-pip"
  sku                 = "Standard" # required for Private Link Service
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  allocation_method   = "Static"
}

resource "azurerm_lb" "example" {
  name                = "example-lb"
  sku                 = "Standard" # required for Private Link Service
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name

  frontend_ip_configuration {
    name                 = azurerm_public_ip.example.name
    public_ip_address_id = azurerm_public_ip.example.id
  }
}

resource "azurerm_private_link_service" "example" {
  name                = "example-privatelink"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name

  nat_ip_configuration {
    name      = azurerm_public_ip.example.name
    primary   = true
    subnet_id = azurerm_subnet.service.id
  }

  load_balancer_frontend_ip_configuration_ids = [
    azurerm_lb.example.frontend_ip_configuration[0].id,
  ]
}

# used by consumers to connect to Private Link Service
resource "azurerm_private_endpoint" "example" {
  name                = "example-endpoint"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  subnet_id           = azurerm_subnet.endpoint.id

  private_service_connection {
    name                           = "example-privateserviceconnection"
    private_connection_resource_id = azurerm_private_link_service.example.id
    is_manual_connection           = false # connection is automatically approved
  }
}

###

# Use Private Link Service Alias with existing resources
resource "azurerm_private_endpoint" "example" {
  name                = "example-endpoint"
  location            = data.azurerm_resource_group.example.location
  resource_group_name = data.azurerm_resource_group.example.name
  subnet_id           = data.azurerm_subnet.subnet.id

  private_service_connection {
    name                              = "example-privateserviceconnection"
    private_connection_resource_alias = "example-privatelinkservice.d20286c8-4ea5-11eb-9584-8f53157226c6.centralus.azure.privatelinkservice"
    # <private-link-name>.<subscription-id>.<region>.azure.privatelinkservice
    is_manual_connection              = true  # providing alias requires manual approval from service owner
    request_message                   = "PL"
  }
}
