
data "azurerm_resource_group" "rg" {
  name = var.rg_name
}

data "azurerm_subnet" "subnet" {
  name                 = var.subnet_name
  virtual_network_name = var.vnet_name
  resource_group_name  = var.vnet_rg_name

  depends_on = [data.azurerm_resource_group.rg]
}

resource "azurerm_public_ip" "agw_pip" {
  allocation_method   = "Static"
  location            = data.azurerm_resource_group.rg.location
  name                = "${var.agw_name}-pip"
  resource_group_name = data.azurerm_resource_group.rg.name
  sku                 = "Standard"
}

locals {
  backend_address_pool_name      = "${data.azurerm_subnet.subnet.name}-beap"
  frontend_port_name             = "${data.azurerm_subnet.subnet.name}-feport"
  frontend_ip_configuration_name = "${data.azurerm_subnet.subnet.name}-feip"
  http_setting_name              = "${data.azurerm_subnet.subnet.name}-be-htst"
  listener_name                  = "${data.azurerm_subnet.subnet.name}-httplstn"
  request_routing_rule_name      = "${data.azurerm_subnet.subnet.name}-rqrt"
  redirect_configuration_name    = "${data.azurerm_subnet.subnet.name}-rdrcfg"
}

resource "azurerm_application_gateway" "agw" {
  location            = var.location
  name                = var.agw_name
  resource_group_name = data.azurerm_resource_group.rg.name
  autoscale_configuration {
    min_capacity = 0
    max_capacity = 2
  }
  sku {
    name = "Standard_v2"
    tier = "Standard_v2"
  }
  backend_address_pool {
    name = local.backend_address_pool_name
  }
  backend_http_settings {
    cookie_based_affinity = "Disabled"
    name                  = local.http_setting_name
    port                  = 5000
    protocol              = "Http"
  }
  frontend_ip_configuration {
    name                 = local.frontend_ip_configuration_name
    public_ip_address_id = azurerm_public_ip.agw_pip.id
  }
  frontend_port {
    name = local.frontend_port_name
    port = 80
  }
  gateway_ip_configuration {
    name      = "${var.agw_name}"
    subnet_id = data.azurerm_subnet.subnet.id
  }
  http_listener {
    frontend_ip_configuration_name = local.frontend_ip_configuration_name
    frontend_port_name             = local.frontend_port_name
    name                           = local.listener_name
    protocol                       = "Http"
  }
  request_routing_rule {
    http_listener_name         = local.listener_name
    name                       = local.request_routing_rule_name
    rule_type                  = "Basic"
    backend_address_pool_name  = local.backend_address_pool_name
    backend_http_settings_name = local.http_setting_name
  }

}

output "agw_backpool" {
  value = azurerm_application_gateway.agw.backend_address_pool[0].id
}