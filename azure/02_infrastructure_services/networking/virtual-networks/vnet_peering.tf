# PEERING connect multiple VNets across different regions (traffic goes through Azure backbone)

resource "azurerm_virtual_network_peering" "peering_p_to_hub" {
  name                      = "peer_${azurerm_virtual_network.vnet_p.name}_to_${azurerm_virtual_network.vnet_hub.name}"
  remote_virtual_network_id = azurerm_virtual_network.vnet_hub.id
  resource_group_name       = azurerm_virtual_network.vnet_p.resource_group_name
  virtual_network_name      = azurerm_virtual_network.vnet_p.name
  allow_forwarded_traffic   = true
}

resource "azurerm_virtual_network_peering" "peering_hub_to_p" {
  name                      = "peer${azurerm_virtual_network.vnet_hub.name}_to_${azurerm_virtual_network.vnet_p.name}"
  remote_virtual_network_id = azurerm_virtual_network.vnet_p.id
  resource_group_name       = azurerm_virtual_network.vnet_hub.resource_group_name
  virtual_network_name      = azurerm_virtual_network.vnet_hub.name
  allow_forwarded_traffic   = true
}
