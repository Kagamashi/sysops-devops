# Layer 4 (TCP/UDP) load balancer.
# distributed incoming network traffic across a group of Azure VMs or instances in a VMSS

# SKUs:
#   Basic: small apps/test environments, no HA, open to internet (not secure), desn't support Cross-VNet peering
#   Standard: enterprise/production workloads, HA, requires NSG rule, supports Cross-VNet peering

# Components:
#   Frontend IP Configuration – public or private IP that clients use to connect to the application 
#   Backend Pool – a group of VMs or VM Scale Sets receiving traffic.
#   Health Probes – periodic checks to determine backend VM health
#     - TCP probe: success if TCP session can be established
#     - HTTP/S probe: success if HTTP 200 response is returned
#   Load Balancing Rules – define how traffic is distributed to the backend pool
#   Outbound Rules – configures Source Network Address Translation (SNAT) for outbound traffic from backend instances to internet

# Internal Load Balancer : uses private IP to route traffic within Azure VNets
# Public Load Balancer: exposes a public IP to distribute internet-facing traffic

# Best practices: https://learn.microsoft.com/en-us/azure/load-balancer/load-balancer-best-practices
#   - unblock 168.63.129.16 IP address which is used by health probes from Azure Load Balancer

resource "azurerm_public_ip" "lb_public_ip" {
  name                = "advanced-lb-public-ip"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  allocation_method   = "Static"
  sku                 = "Standard"
}

resource "azurerm_lb" "example_lb" {
  name                = "advanced-lb"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  sku                 = "Standard"

  frontend_ip_configuration {
    name                 = "frontend-ip"
    public_ip_address_id = azurerm_public_ip.lb_public_ip.id
  }
}

# handles HTTP (port 80) traffic
resource "azurerm_lb_backend_address_pool" "http_pool" {
  name            = "http-backend-pool"
  loadbalancer_id = azurerm_lb.example_lb.id
}


# handles HTTPS (port 443) traffic
resource "azurerm_lb_backend_address_pool" "https_pool" {
  name            = "https-backend-pool"
  loadbalancer_id = azurerm_lb.example_lb.id
}

# checks if backend VMs respond on /health every 5 seconds
resource "azurerm_lb_probe" "http_probe" {
  name            = "http-health-probe"
  loadbalancer_id = azurerm_lb.example_lb.id
  protocol        = "Http"
  port            = 80
  request_path    = "/health"
  interval_in_seconds = 5
  number_of_probes = 2 # if VM fails 
}

# routes HTTP traffic to http_pool
resource "azurerm_lb_rule" "http_rule" {
  name                           = "http-load-balancing-rule"
  loadbalancer_id                = azurerm_lb.example_lb.id
  protocol                       = "Tcp"
  frontend_port                  = 80
  backend_port                   = 80
  frontend_ip_configuration_name = "frontend-ip"
  probe_id                       = azurerm_lb_probe.http_probe.id
}

# routes HTTPS traffic to https_pool
resource "azurerm_lb_rule" "https_rule" {
  name                           = "https-load-balancing-rule"
  loadbalancer_id                = azurerm_lb.example_lb.id
  protocol                       = "Tcp"
  frontend_port                  = 443
  backend_port                   = 443
  frontend_ip_configuration_name = "frontend-ip"
}

# allows SSH access to VMs via port 50000 from Load Balancer
resource "azurerm_lb_nat_rule" "ssh_nat_rule" {
  name                           = "ssh-nat-rule"
  resource_group_name = azurerm_resource_group.example.name
  loadbalancer_id                = azurerm_lb.example_lb.id
  protocol                       = "Tcp"
  frontend_port                  = 50000
  backend_port                   = 22
  frontend_ip_configuration_name = "frontend-ip"
}

# ensures VMs in backend pool can access internet using SNAT (Source Network Address Translation)
resource "azurerm_lb_outbound_rule" "outbound_rule" {
  name                           = "outbound-rule"
  loadbalancer_id                = azurerm_lb.example_lb.id
  protocol                       = "All"
  backend_address_pool_id        = azurerm_lb_backend_address_pool.http_pool.id
  enable_tcp_reset               = true
}

# VMSS connected to backend addresss pools from Load Balancer
resource "azurerm_linux_virtual_machine_scale_set" "vmss" {
  name                = "autoscale-vmss"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  sku                 = "Standard_DS2_v2"
  instances           = 2
  admin_username      = "adminuser"
  admin_password      = "SecureP@ssword123!"
  disable_password_authentication = false

  network_interface {
    name                      = "vmss-nic"
    primary                   = true

    ip_configuration {
      name      = "internal"
      subnet_id = azurerm_subnet.example_subnet.id  # !!!
      load_balancer_backend_address_pool_ids = [    # list of backend adress pools IDs from Load Balancer which this VMSS should be connected to
        azurerm_lb_backend_address_pool.http_pool.id,
        azurerm_lb_backend_address_pool.https_pool.id
      ]
    }
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }
}
