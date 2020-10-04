#Deploy de uma VNET, respetivas subnets e respetivos NSGs das subnets e regras dos NSGs
module "global_variables" {
  source = "../../../global_variables"
}


data "azurerm_resource_group" "rg_spoke" {
  name = var.rg_spoke
}

data "azurerm_resource_group" "rg_hub" {
  name = var.rg_hub
}

data azurerm_virtual_network "vnet_spoke" {
  name                = var.name_vnet_spoke
  resource_group_name = var.rg_spoke
}

data azurerm_virtual_network "vnet_hub" {
  name                = var.name_vnet_hub
  resource_group_name = var.rg_hub
}

resource "azurerm_virtual_network_peering" "peering1" {
  name                         = "${var.name_vnet_spoke}-to-${var.name_vnet_hub}"
  resource_group_name          = data.azurerm_resource_group.rg_spoke.name
  virtual_network_name         = var.name_vnet_spoke
  remote_virtual_network_id    = data.azurerm_virtual_network.vnet_hub.id
  use_remote_gateways          = "true"
  allow_virtual_network_access = true
  allow_forwarded_traffic      = true

}

resource "azurerm_virtual_network_peering" "peering2" {
  name                         = "${var.name_vnet_hub}-to-${var.name_vnet_spoke}"
  resource_group_name          = data.azurerm_resource_group.rg_hub.name
  virtual_network_name         = var.name_vnet_hub
  remote_virtual_network_id    = data.azurerm_virtual_network.vnet_spoke.id
  allow_virtual_network_access = true
  allow_forwarded_traffic      = true
  allow_gateway_transit        = true
  //location           =  var.location_peering

}