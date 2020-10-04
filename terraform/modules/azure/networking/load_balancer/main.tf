module "global_variables" {
  source = "../../../global_variables"
}
data "azurerm_resource_group" "rg" {
  name = var.rg_name
}

data "azurerm_subnet" "subnet" {
  name                 = var.subnet_id
  virtual_network_name = var.vnet_name
  resource_group_name  = var.vnet_rg_name

  depends_on = [data.azurerm_resource_group.rg]
}

data "azurerm_network_interface" "nic" {
  count               = length(var.Vm_NICs)
  name                = var.Vm_NICs[count.index]
  resource_group_name = var.rg_name
}
data "azurerm_virtual_machine" "vm" {
  count               = length(var.vm_names)
  resource_group_name = var.rg_name
  name                = var.vm_names[count.index]
}

resource "azurerm_lb" "lb" {
  name                = var.lb_name
  resource_group_name = var.rg_name
  location            = var.location
  sku                 = var.lb_sku
  frontend_ip_configuration {
    name                          = var.frontend_ip_configuration_name
    subnet_id                     = data.azurerm_subnet.subnet.id
    private_ip_address            = var.private_id_address
    private_ip_address_allocation = var.private_ip_address_allocation
  }

  tags = {
    ChangeDate      = formatdate("YYYYMMDD", timestamp())
    CostCenter      = var.tags.CostCenter
    Environment     = var.tags.Environment
    ExpirationDate  = var.tags.ExpirationDate
    Owner           = var.tags.Owner
    RunningInterval = var.tags.RunningInterval
    ServiceType     = module.global_variables.databricks_service_type
    Solution        = var.tags.Solution
  }
}
resource "azurerm_lb_probe" "prb" {
  resource_group_name = var.rg_name
  loadbalancer_id     = azurerm_lb.lb.id
  name                = var.probe_name
  port                = var.probe_port
  interval_in_seconds = var.probe_interval_in_seconds
  protocol            = var.probe_protocol
}
resource "azurerm_lb_backend_address_pool" "example" {
  resource_group_name = var.rg_name
  loadbalancer_id     = azurerm_lb.lb.id
  name                = var.BackEndAddressPoolName
}
resource "azurerm_lb_rule" "example" {
  resource_group_name            = var.rg_name
  loadbalancer_id                = azurerm_lb.lb.id
  name                           = var.lb_rule_name
  protocol                       = var.lb_rule_protocol
  frontend_port                  = var.lb_rule_frontend_port
  backend_port                   = var.lb_rule_backend_port
  backend_address_pool_id        = azurerm_lb_backend_address_pool.example.id
  frontend_ip_configuration_name = var.frontend_ip_configuration_name
  load_distribution              = var.lb_rule_load_distribution
  probe_id                       = azurerm_lb_probe.prb.id
  enable_floating_ip             = var.lb_enable_floating_ip

}
resource "azurerm_network_interface_backend_address_pool_association" "example" {
  count                 = length(data.azurerm_network_interface.nic)
  network_interface_id  = data.azurerm_network_interface.nic[count.index].id
  ip_configuration_name = "${lookup(data.azurerm_virtual_machine.vm[count.index], "name")}-ipconfig"
  //ip_configuration_name   = data.azurerm_network_interface.nic[count.index].ip_configuration[0].name
  backend_address_pool_id = azurerm_lb_backend_address_pool.example.id
}