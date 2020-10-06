provider "azurerm" {
  features {}
}
module "global_variables" {
  source = "../global_variables"
}


module "agw" {
  source = "../../../../modules/azure/networking/app_gateway"

  agw_name     = module.global_variables.agw_name
  location     = module.global_variables.location
  rg_name      = module.global_variables.rg_name
  subnet_name  = "${module.global_variables.vnet_name}-agw"
  vnet_name    = module.global_variables.vnet_name
  vnet_rg_name = module.global_variables.rg_name
}