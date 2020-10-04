# For On-Prem Data Gateway network requirements see https://docs.microsoft.com/en-us/azure/analysis-services/analysis-services-gateway

resource "azurerm_network_security_rule" "this" {
  count                        = length(var.nsg_rules)
  name                         = lookup(var.nsg_rules[count.index], "name")
  priority                     = lookup(var.nsg_rules[count.index], "priority")
  direction                    = lookup(var.nsg_rules[count.index], "direction")
  access                       = lookup(var.nsg_rules[count.index], "access")
  protocol                     = lookup(var.nsg_rules[count.index], "protocol")
  source_port_range            = lookup(var.nsg_rules[count.index], "source_port_range", null)
  source_port_ranges           = lookup(var.nsg_rules[count.index], "source_port_ranges", null)
  source_address_prefix        = lookup(var.nsg_rules[count.index], "source_address_prefix", null)
  source_address_prefixes      = lookup(var.nsg_rules[count.index], "source_address_prefixes", null)
  destination_port_range       = lookup(var.nsg_rules[count.index], "destination_port_range", null)
  destination_port_ranges      = lookup(var.nsg_rules[count.index], "destination_port_ranges", null)
  destination_address_prefix   = lookup(var.nsg_rules[count.index], "destination_address_prefix", null)
  destination_address_prefixes = lookup(var.nsg_rules[count.index], "destination_address_prefixes", null)
  network_security_group_name  = var.nsg_name
  resource_group_name          = var.rg_name
}