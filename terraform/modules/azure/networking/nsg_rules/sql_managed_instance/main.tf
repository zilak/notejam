resource "azurerm_network_security_rule" "sqlmi_rule_1" {
  name                        = "allow-management-inbound"
  description                 = "Allow inbound TCP traffic on ports 9000,9003,1438,1440,1452"
  access                      = "Allow"
  priority                    = 110
  direction                   = "Inbound"
  protocol                    = "Tcp"
  source_port_range           = "*"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  destination_port_ranges     = ["9000", "9003", "1438", "1440", "1452"]
  resource_group_name         = var.rg_name
  network_security_group_name = var.nsg_name
}

resource "azurerm_network_security_rule" "sqlmi_rule_2" {
  name                        = "allow-mi_subnet-inbound"
  description                 = "Allow inbound inter-node traffic"
  access                      = "Allow"
  priority                    = 160
  direction                   = "Inbound"
  protocol                    = "*"
  source_port_range           = "*"
  source_address_prefix       = var.subnet_scope
  destination_address_prefix  = "*"
  destination_port_range      = "*"
  resource_group_name         = var.rg_name
  network_security_group_name = var.nsg_name
}

resource "azurerm_network_security_rule" "sqlmi_rule_3" {
  name                        = "allow-health_probe-inbound"
  description                 = "Allow health probe inbound"
  access                      = "Allow"
  priority                    = 170
  direction                   = "Inbound"
  protocol                    = "*"
  source_port_range           = "*"
  source_address_prefix       = "AzureLoadBalancer"
  destination_address_prefix  = "*"
  destination_port_range      = "*"
  resource_group_name         = var.rg_name
  network_security_group_name = var.nsg_name
}

resource "azurerm_network_security_rule" "sqlmi_rule_4" {
  name                        = "allow-management-outbound"
  description                 = "Allow outbound TCP traffic on port 80,443,12000"
  access                      = "Allow"
  priority                    = 110
  direction                   = "Outbound"
  protocol                    = "Tcp"
  source_port_range           = "*"
  source_address_prefix       = "*"
  destination_address_prefix  = "AzureCloud"
  destination_port_ranges     = ["80", "443", "12000"]
  resource_group_name         = var.rg_name
  network_security_group_name = var.nsg_name
}

resource "azurerm_network_security_rule" "sqlmi_rule_5" {
  name                        = "allow-mi_subnet-outbound"
  description                 = "Allow outbound inter-node traffic"
  access                      = "Allow"
  priority                    = 140
  direction                   = "Outbound"
  protocol                    = "*"
  source_port_range           = "*"
  source_address_prefix       = "*"
  destination_address_prefix  = var.subnet_scope
  destination_port_range      = "*"
  resource_group_name         = var.rg_name
  network_security_group_name = var.nsg_name
}
