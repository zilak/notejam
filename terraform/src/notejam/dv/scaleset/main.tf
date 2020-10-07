provider "azurerm" {
  features {}
}
module "global_variables" {
  source = "../global_variables"
}

module "scaleset" {
  source                  = "../../../../modules/azure/compute/vm/scaleset_windows"
  image_id                = "/subscriptions/a38fac22-fdcb-4f4d-a843-e162d0f2f420/resourceGroups/notejamdev/providers/Microsoft.Compute/images/notejamdev"
  instances               = 1
  kv_name                 = module.global_variables.kv_name
  kv_password_secret_name = "password"
  kv_rg_name              = module.global_variables.rg_name
  kv_username_secret_name = "username"
  location                = module.global_variables.location
  log_rg                  = module.global_variables.rg_name
  log_workspace           = module.global_variables.log_analytics_name
  rg_name                 = module.global_variables.rg_name
  scale_set_name          = "notejam"
  sku                     = "Standard_B2s"
  subnet_name             = "${module.global_variables.vnet_name}-app"
  subnet_rg_name          = module.global_variables.rg_name
  tags                    = {}
  vnet_name               = module.global_variables.vnet_name
  agw_pool_id             = "/subscriptions/a38fac22-fdcb-4f4d-a843-e162d0f2f420/resourceGroups/notejamdev/providers/Microsoft.Network/applicationGateways/notejamagwdev/backendAddressPools/notejamvnetdev-agw-beap"
}