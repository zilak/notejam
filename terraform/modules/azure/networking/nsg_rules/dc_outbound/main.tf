resource "azurerm_network_security_rule" "outbound_rule" {
  count                        = length(var.nsg_name)
  name                         = "${var.rule_outbound_name}-${var.rule_access}"
  priority                     = var.rule_pritority
  direction                    = "Outbound"
  access                       = var.rule_access
  protocol                     = "*"
  source_port_range            = var.rule_source_port
  destination_port_ranges      = var.rule_dest_port
  source_address_prefixes      = var.rule_source_address
  destination_address_prefixes = var.rule_dest_address
  resource_group_name          = var.rg_name
  network_security_group_name  = var.nsg_name[count.index]
}
