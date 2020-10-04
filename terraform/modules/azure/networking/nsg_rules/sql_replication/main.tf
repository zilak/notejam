
resource "azurerm_network_security_rule" "inbound_rule" {
  name                         = "${var.rule_inbound_name}-${var.rule_access}"
  priority                     = var.rule_pritority
  direction                    = "Inbound"
  access                       = var.rule_access
  protocol                     = var.rule_protocol
  source_port_range            = var.rule_source_port
  destination_port_ranges      = var.rule_dest_ports
  source_address_prefixes      = var.remote_address
  destination_address_prefixes = [var.local_address]
  resource_group_name          = var.rg_name
  network_security_group_name  = var.nsg_name
}

resource "azurerm_network_security_rule" "outbound_rule" {
  name                         = "${var.rule_outbound_name}-${var.rule_access}"
  priority                     = var.rule_pritority
  direction                    = "Outbound"
  access                       = var.rule_access
  protocol                     = var.rule_protocol
  source_port_range            = var.rule_source_port
  destination_port_ranges      = var.rule_dest_ports
  source_address_prefixes      = [var.local_address]
  destination_address_prefixes = var.remote_address
  resource_group_name          = var.rg_name
  network_security_group_name  = var.nsg_name
}

