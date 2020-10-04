data "azurerm_private_dns_zone" "dns_zone" {
  name                = var.private_dns_name
  resource_group_name = var.private_dns_rg_name
}


resource "azurerm_private_dns_cname_record" "a_record" {
  name                = var.cname_record_name
  zone_name           = data.azurerm_private_dns_zone.dns_zone.name
  resource_group_name = data.azurerm_private_dns_zone.dns_zone.resource_group_name
  ttl                 = var.ttl
  record              = var.record
}