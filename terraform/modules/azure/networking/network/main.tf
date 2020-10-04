#Deploy de uma VNET, respetivas subnets e respetivos NSGs das subnets e regras dos NSGs

data "azurerm_resource_group" "rg" {
  name = var.rg_name
}

#VNet creation
resource "azurerm_virtual_network" "vnet" {
  name                = var.vnet_name
  location            = var.location
  resource_group_name = data.azurerm_resource_group.rg.name
  address_space       = var.vnet_address_space


  dns_servers = var.dns_server
}



//TODO adicionar service endpoints
#Subnet creation. There can be N subnets per VNET.
resource "azurerm_subnet" "subnet" {
  count                = length(var.subnets)
  name                 = "${azurerm_virtual_network.vnet.name}-${lookup(var.subnets[count.index], "subnet_name")}"
  resource_group_name  = data.azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefix       = lookup(var.subnets[count.index], "subnet_address_space")

  //  dynamic "service_endpoints" {
  //    for_each = var.subnets[count.index].service_endpoints == [""] ? [] : var.subnets
  //    content {
  //      service_endpoints = var.subnets[count.index].service_endpoints
  //    }
  //  }

  enforce_private_link_service_network_policies  = var.subnets[count.index].enable_private_link == "false" ? false : true
  enforce_private_link_endpoint_network_policies = var.subnets[count.index].enable_private_endpoint == "false" ? false : true
  service_endpoints                              = var.subnets[count.index].service_endpoints
  dynamic "delegation" {
    for_each = [for s in var.subnets[count.index].delegation : {
      name                    = s.name
      service_delegation_name = s.service_delegation_name
    }]
    content {
      name = delegation.value.name
      service_delegation {
        name = delegation.value.service_delegation_name
      }
    }
  }

  lifecycle {
    #ignore_changes = ["network_security_group_id", "route_table_id"]
  }

}
#NSGs are defined at subnet level. Therefore after the subnet is created, a NSG for each subnet will be created when the subnets are deployed
resource "azurerm_network_security_group" "nsg" {
  count               = length(var.subnets)
  name                = "${azurerm_subnet.subnet.*.name[count.index]}-nsg"
  location            = data.azurerm_resource_group.rg.location
  resource_group_name = data.azurerm_resource_group.rg.name

  depends_on = [azurerm_subnet.subnet]
}

#Associate a NSG to a subnet
resource "azurerm_subnet_network_security_group_association" "nsg_associate_subnet" {
  count                     = length(var.subnets)
  subnet_id                 = azurerm_subnet.subnet.*.id[count.index]
  network_security_group_id = azurerm_network_security_group.nsg.*.id[count.index]

  depends_on = [azurerm_network_security_group.nsg]
}
//TODO Considerar source_address_prefix (ex: "*", "virtualNetwork")
#NSG rules per NSG are dynamically created
//noinspection ConflictingProperties
resource "azurerm_network_security_rule" "nsg_rule" {
  count                        = length(var.nsg_rules)
  name                         = lookup(var.nsg_rules[count.index], "name")
  priority                     = lookup(var.nsg_rules[count.index], "priority")
  direction                    = lookup(var.nsg_rules[count.index], "direction")
  access                       = lookup(var.nsg_rules[count.index], "access")
  protocol                     = lookup(var.nsg_rules[count.index], "protocol")
  source_port_range            = lookup(var.nsg_rules[count.index], "source_port_range", null)
  source_port_ranges           = lookup(var.nsg_rules[count.index], "source_port_ranges", null)
  source_address_prefixes      = lookup(var.nsg_rules[count.index], "source_address_prefixes") != ["*"] ? lookup(var.nsg_rules[count.index], "source_address_prefixes") : null
  destination_port_range       = lookup(var.nsg_rules[count.index], "destination_port_range", null)
  destination_port_ranges      = lookup(var.nsg_rules[count.index], "destination_port_ranges", null)
  destination_address_prefix   = lookup(var.nsg_rules[count.index], "destination_address_prefix", null)
  destination_address_prefixes = lookup(var.nsg_rules[count.index], "destination_address_prefixes", null)
  resource_group_name          = data.azurerm_resource_group.rg.name
  network_security_group_name  = lookup(var.nsg_rules[count.index], "nsg_name")

  depends_on = [azurerm_network_security_group.nsg]
}

resource "azurerm_virtual_network_peering" "spoke_peering" {
  count                        = var.spoke_vnet_peering == null ? 0 : length(var.spoke_vnet_peering)
  name                         = "${azurerm_virtual_network.vnet.name}-${var.spoke_vnet_peering[count.index].remote_vnet_name}"
  remote_virtual_network_id    = var.spoke_vnet_peering[count.index].remote_vnet_id
  resource_group_name          = data.azurerm_resource_group.rg.name
  virtual_network_name         = azurerm_virtual_network.vnet.name
  allow_virtual_network_access = var.spoke_vnet_peering_config.vnet_access
  allow_forwarded_traffic      = var.spoke_vnet_peering_config.forwarded_traffic
  allow_gateway_transit        = var.spoke_vnet_peering_config.gateway_transit
  use_remote_gateways          = var.spoke_vnet_peering_config.remote_gateway
}

resource "azurerm_virtual_network_peering" "hub_peering" {
  count                        = var.hub_vnet_peering == null ? 0 : length(var.hub_vnet_peering)
  name                         = "${azurerm_virtual_network.vnet.name}-${var.hub_vnet_peering[count.index].remote_vnet_name}"
  remote_virtual_network_id    = var.hub_vnet_peering[count.index].remote_vnet_id
  resource_group_name          = data.azurerm_resource_group.rg.name
  virtual_network_name         = azurerm_virtual_network.vnet.name
  allow_virtual_network_access = var.hub_vnet_peering_config.vnet_access
  allow_forwarded_traffic      = var.hub_vnet_peering_config.forwarded_traffic
  allow_gateway_transit        = var.hub_vnet_peering_config.gateway_transit
  use_remote_gateways          = var.hub_vnet_peering_config.remote_gateway
}

output "nsg_name" {
  value = azurerm_network_security_group.nsg.*.name
}

output "subnet_id" {
  value = azurerm_subnet.subnet.*.id
}

output "rg_name" {
  value = var.rg_name
}

output "rg_location" {
  value = data.azurerm_resource_group.rg.location
}