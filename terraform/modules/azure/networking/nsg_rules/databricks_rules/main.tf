
resource "azurerm_network_security_rule" "nsg_rule_worker_to_worker" {
  name                        = "databricks-worker-to-worker-inbound"
  resource_group_name         = var.rg_name
  network_security_group_name = var.nsg_name
  access                      = "Allow"
  direction                   = "Inbound"
  priority                    = "250"
  protocol                    = "*"
  source_address_prefix       = "VirtualNetwork"
  destination_address_prefix  = "*"
  destination_port_range      = "*"
  source_port_range           = "*"
}

resource "azurerm_network_security_rule" "nsg_rule_ssh" {
  name                        = "databricks-control-plane-ssh"
  resource_group_name         = var.rg_name
  network_security_group_name = var.nsg_name
  access                      = "Allow"
  direction                   = "Inbound"
  priority                    = "251"
  protocol                    = "*"
  source_address_prefix       = "23.100.0.135/32"
  destination_address_prefix  = "*"
  destination_port_range      = "22"
  source_port_range           = "*"
}

resource "azurerm_network_security_rule" "nsg_rule_proxy" {
  name                        = "databricks-control-plane-worker-proxy"
  resource_group_name         = var.rg_name
  network_security_group_name = var.nsg_name
  access                      = "Allow"
  direction                   = "Inbound"
  priority                    = "252"
  protocol                    = "*"
  source_address_prefix       = "23.100.0.135/32"
  destination_address_prefix  = "*"
  destination_port_range      = "5557"
  source_port_range           = "*"
}

resource "azurerm_network_security_rule" "nsg_rule_to_webapp" {
  name                        = "databricks-worker-to-webapp"
  resource_group_name         = var.rg_name
  network_security_group_name = var.nsg_name
  access                      = "Allow"
  direction                   = "Outbound"
  priority                    = "250"
  protocol                    = "*"
  source_address_prefix       = "*"
  destination_address_prefix  = "52.232.19.246/32"
  destination_port_range      = "*"
  source_port_range           = "*"
}

resource "azurerm_network_security_rule" "nsg_rule_to_sql" {
  name                        = "databricks-worker-to-sql"
  resource_group_name         = var.rg_name
  network_security_group_name = var.nsg_name
  access                      = "Allow"
  direction                   = "Outbound"
  priority                    = "251"
  protocol                    = "*"
  source_address_prefix       = "*"
  destination_address_prefix  = "Sql"
  destination_port_range      = "*"
  source_port_range           = "*"
}

resource "azurerm_network_security_rule" "nsg_rule_to_storage" {
  name                        = "databricks-worker-to-storage"
  resource_group_name         = var.rg_name
  network_security_group_name = var.nsg_name
  access                      = "Allow"
  direction                   = "Outbound"
  priority                    = "252"
  protocol                    = "*"
  source_address_prefix       = "*"
  destination_address_prefix  = "Storage"
  destination_port_range      = "*"
  source_port_range           = "*"
}

resource "azurerm_network_security_rule" "nsg_rule_to_worker" {
  name                        = "databricks-worker-to-worker-outbound"
  resource_group_name         = var.rg_name
  network_security_group_name = var.nsg_name
  access                      = "Allow"
  direction                   = "Outbound"
  priority                    = "253"
  protocol                    = "*"
  source_address_prefix       = "*"
  destination_address_prefix  = "VirtualNetwork"
  destination_port_range      = "*"
  source_port_range           = "*"
}

resource "azurerm_network_security_rule" "nsg_rule_to_eventhub" {
  name                        = "databricks-worker-to-eventhub"
  resource_group_name         = var.rg_name
  network_security_group_name = var.nsg_name
  access                      = "Allow"
  direction                   = "Outbound"
  priority                    = "254"
  protocol                    = "*"
  source_address_prefix       = "VirtualNetwork"
  destination_address_prefix  = "EventHub"
  destination_port_range      = "*"
  source_port_range           = "*"
}






