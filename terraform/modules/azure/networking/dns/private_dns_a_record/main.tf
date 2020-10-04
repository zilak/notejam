resource "azurerm_private_dns_zone" "dns_zone" {
  name                = var.private_dns_name
  resource_group_name = var.private_dns_rg_name
}
data "azurerm_virtual_network" "vnet" {
  name                = var.vnet_name
  resource_group_name = var.private_dns_rg_name
}
resource "azurerm_private_dns_a_record" "a_record" {
  name                = var.a_record_name
  zone_name           = azurerm_private_dns_zone.dns_zone.name
  resource_group_name = azurerm_private_dns_zone.dns_zone.resource_group_name
  ttl                 = var.ttl
  records             = [var.ip_address]
}

resource "azurerm_private_dns_zone_virtual_network_link" "private_dns_vnet_link" {
  name                  = "${data.azurerm_virtual_network.vnet.name}-link"
  resource_group_name   = var.private_dns_rg_name
  private_dns_zone_name = var.private_dns_name
  virtual_network_id    = data.azurerm_virtual_network.vnet.id
}
