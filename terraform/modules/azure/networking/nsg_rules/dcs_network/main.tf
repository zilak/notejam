

resource "azurerm_network_security_rule" "outbound_rule" {
  name                         = "${var.rule_name}-outbound-${var.rule_access}"
  priority                     = var.rule_pritority
  direction                    = "Outbound"
  access                       = var.rule_access
  protocol                     = "*"
  source_port_ranges           = var.dc_client_port
  destination_port_ranges      = var.dc_server_port
  source_address_prefixes      = var.rule_source_address
  destination_address_prefixes = var.rule_dest_address
  resource_group_name          = var.rg_name
  network_security_group_name  = var.nsg_name
}

resource "azurerm_network_security_rule" "inbound_rule" {
  name                         = "${var.rule_name}-inbound-${var.rule_access}"
  priority                     = var.rule_pritority
  direction                    = "Inbound"
  access                       = var.rule_access
  protocol                     = "*"
  source_port_ranges           = var.dc_client_port
  destination_port_ranges      = var.dc_server_port
  source_address_prefixes      = var.rule_source_address
  destination_address_prefixes = var.rule_dest_address
  resource_group_name          = var.rg_name
  network_security_group_name  = var.nsg_name
}




