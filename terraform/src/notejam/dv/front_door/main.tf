provider "azurerm" {
  version = "2.23.0"
  features {}
}
module "global_variables" {
  source = "../global_variables"
}


module "agw" {
  source = "../../../../modules/azure/networking/front_door"

  backend        = var.backend
  frontdoor_name = var.frontdoor_name
  location       = module.global_variables.location
  rg_name        = module.global_variables.rg_name
}