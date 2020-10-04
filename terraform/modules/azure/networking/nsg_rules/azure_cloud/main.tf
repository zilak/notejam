
resource "azurerm_network_security_rule" "outbound_rule" {
  name                        = "azure-${var.rule_direction}-${var.rule_access}"
  priority                    = var.rule_pritority
  direction                   = var.rule_direction
  access                      = var.rule_access
  protocol                    = var.rule_protocol
  source_port_range           = var.rule_source_port
  destination_port_range      = var.rule_dest_port
  source_address_prefixes     = var.rule_source_address
  destination_address_prefix  = var.rule_dest_address
  resource_group_name         = var.rg_name
  network_security_group_name = var.nsg_name
}



