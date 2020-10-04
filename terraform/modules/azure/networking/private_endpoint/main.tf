
data azurerm_subnet "subnet" {
  name                 = var.subnet_name
  resource_group_name  = var.subnet_rg_name
  virtual_network_name = var.vnet_name
}



resource "azurerm_private_endpoint" "endpoint" {
  name                = var.name
  location            = var.location
  resource_group_name = var.rg_name
  subnet_id           = data.azurerm_subnet.subnet.id

  private_service_connection {
    is_manual_connection           = var.is_manual_connection
    name                           = var.connection_name
    private_connection_resource_id = var.private_connection_resource_id
    subresource_names              = var.subresource_names
  }
}

output "private_ip_address" {
  value = lookup(azurerm_private_endpoint.endpoint.private_service_connection[0], "private_ip_address", "")
}
