
resource "azurerm_network_security_rule" "inbound_rule" {
  name                         = "${var.rule_inbound_name}-${var.rule_access}"
  priority                     = var.rule_pritority
  direction                    = "Inbound"
  access                       = var.rule_access
  protocol                     = var.rule_protocol
  source_port_range            = var.rule_source_port
  destination_port_ranges      = var.rule_dest_ports
  source_address_prefixes      = var.rule_source_address
  destination_address_prefixes = var.rule_dest_address
  resource_group_name          = var.rg_name
  network_security_group_name  = var.nsg_name
}




