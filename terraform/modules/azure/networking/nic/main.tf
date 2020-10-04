module "global_variables" {
  source = "../../../global_variables"
}
data "azurerm_resource_group" "rg" {
  name = var.rg_name
}

/*
resource "azurerm_network_interface" "example" {
  name                = "acceptanceTestNetworkInterface1"
  location            = "${azurerm_resource_group.example.location}"
  resource_group_name = "${azurerm_resource_group.example.name}"

  ip_configuration {
    name                          = "testconfiguration1"
    subnet_id                     = "${azurerm_subnet.example.id}"
    private_ip_address_allocation = "Dynamic"
  }

  tags = {
    environment = "staging"
  }
}*/
