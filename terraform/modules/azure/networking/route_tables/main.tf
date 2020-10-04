module "global_variables" {
  source = "../../../global_variables"
}

/*
EXAMPLE OF ROUTE_TABLES variable:

[{name = "vnetmainf-mvpwer01-snetdat01"
disable_bgp_route_propagation = true
route = [{
name = "route-to-azfwgen-hubwer01"
address_prefix = "0.0.0.0/0"
next_hop_type = "VirtualAppliance"
next_hop_in_ip_address   = "10.19.68.132"
}]

}]

*/

resource "azurerm_route_table" "route_tables" {
  for_each                      = { for table in var.route_tables : "rt-${table.subnet_name}" => table }
  name                          = each.key
  location                      = var.location
  resource_group_name           = var.rg_name
  disable_bgp_route_propagation = each.value.disable_bgp_route_propagation
  tags = {
    ChangeDate      = formatdate("YYYYMMDD", timestamp())
    CostCenter      = var.tags.CostCenter
    Environment     = var.tags.Environment
    ExpirationDate  = var.tags.ExpirationDate
    Owner           = var.tags.Owner
    RunningInterval = var.tags.RunningInterval
    ServiceType     = module.global_variables.network_service_type
    Solution        = var.tags.Solution
  }

  dynamic "route" {
    for_each = { for route in each.value.route : route.name => route }
    content {
      address_prefix         = route.value.address_prefix
      name                   = route.value.name
      next_hop_type          = route.value.next_hop_type
      next_hop_in_ip_address = route.value.next_hop_in_ip_address
    }
  }
}


data "azurerm_subnet" "subnet" {
  for_each             = { for subnet in var.route_tables : subnet.subnet_name => subnet.subnet_name }
  name                 = each.key
  virtual_network_name = var.vnet_name
  resource_group_name  = var.rg_name
}

resource "azurerm_subnet_route_table_association" "this" {
  for_each       = { for subnet in var.route_tables : subnet.subnet_name => subnet.subnet_name }
  subnet_id      = data.azurerm_subnet.subnet[each.key].id
  route_table_id = azurerm_route_table.route_tables["rt-${each.key}"].id
}