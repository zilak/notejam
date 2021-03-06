

resource "azurerm_network_security_rule" "outbound_rule" {
  count                       = length(var.nsg_name)
  name                        = var.rule_outbound_name
  priority                    = var.rule_pritority
  direction                   = "Outbound"
  access                      = var.rule_access
  protocol                    = var.rule_protocol
  source_port_range           = var.rule_source_port
  destination_port_range      = var.rule_dest_port
  source_address_prefix       = var.rule_source_address
  destination_address_prefix  = var.rule_dest_address
  resource_group_name         = var.rg_name
  network_security_group_name = var.nsg_name[count.index]
}

resource "azurerm_network_security_rule" "inbound_rule" {
  count                       = length(var.nsg_name)
  name                        = var.rule_inbound_name
  priority                    = var.rule_pritority
  direction                   = "Inbound"
  access                      = var.rule_access
  protocol                    = var.rule_protocol
  source_port_range           = var.rule_source_port
  destination_port_range      = var.rule_dest_port
  source_address_prefix       = var.rule_source_address
  destination_address_prefix  = var.rule_dest_address
  resource_group_name         = var.rg_name
  network_security_group_name = var.nsg_name[count.index]
}



