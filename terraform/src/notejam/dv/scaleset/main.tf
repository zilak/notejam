provider "azurerm" {
  features {}
}
module "global_variables" {
  source = "../global_variables"
}

module "scaleset" {
  source                  = "../../../../modules/azure/compute/vm/scaleset_windows"
  image_id                = "/subscriptions/a38fac22-fdcb-4f4d-a843-e162d0f2f420/resourceGroups/nordrg/providers/Microsoft.Compute/images/notejamimage"
  instances               = 1
  kv_name                 = module.global_variables.kv_name
  kv_password_secret_name = "password"
  kv_rg_name              = module.global_variables.rg_name
  kv_username_secret_name = "username"
  location                = module.global_variables.location
  log_rg                  = "nordrg"
  log_workspace           = "lognorddev"
  rg_name                 = "nordrg"
  scale_set_name          = "appdev"
  sku                     = "Standard_B2s"
  subnet_name             = "${module.global_variables.vnet_name}-app"
  subnet_rg_name          = module.global_variables.rg_name
  tags                    = {}
  vnet_name               = module.global_variables.vnet_name
}