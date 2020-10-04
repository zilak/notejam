module "global_variables" {
  source = "../../../global_variables"
}

# Create a Virtual Network Gateway for a Virtual Network
#
#
data "azurerm_resource_group" "rg" {
  name = var.rg_name
}

#
# It is required to have a Public IP for the Virtual Network Gateway
#

data "azurerm_key_vault" "kv" {
  count               = length(var.vpn_client_address_space) == 0 ? 0 : 1
  name                = var.kv_name
  resource_group_name = var.kv_rg_name
}

data "azurerm_key_vault_secret" "kv_secret" {
  count        = length(var.vpn_client_address_space) == 0 ? 0 : 1
  key_vault_id = data.azurerm_key_vault.kv[0].id
  name         = var.kv_secret_name
}

resource "azurerm_public_ip" "vgw_pip" {
  name                = "${var.vnetgateway_name}-pip"
  location            = var.location
  resource_group_name = data.azurerm_resource_group.rg.name

  allocation_method = "Dynamic"
}

data "azurerm_subnet" "subnet" {
  name                 = var.subnet_name
  resource_group_name  = data.azurerm_resource_group.rg.name
  virtual_network_name = var.vnet
}

#
# Create the Virtual Network Gateway
#

resource "azurerm_virtual_network_gateway" "vnetgateway" {
  name                = var.vnetgateway_name
  location            = var.location
  resource_group_name = data.azurerm_resource_group.rg.name

  type = var.type

  enable_bgp    = var.bgp
  sku           = var.sku
  active_active = var.active_active
  dynamic "vpn_client_configuration" {
    for_each = length(var.vpn_client_address_space) == 0 ? [] : ["1"]
    content {
      address_space         = var.vpn_client_address_space
      radius_server_address = var.radius_server_address
      radius_server_secret  = data.azurerm_key_vault_secret.kv_secret[0].value
      vpn_client_protocols  = var.vpn_client_protocols
    }
  }

  ip_configuration {
    name                 = var.vnet_config
    public_ip_address_id = azurerm_public_ip.vgw_pip.id
    subnet_id            = data.azurerm_subnet.subnet.id
  }

  tags = var.tags
}