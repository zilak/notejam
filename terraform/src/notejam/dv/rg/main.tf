provider "azurerm" {
  features {}
}
module "global_variables" {
  source = "../global_variables"
}

resource "azurerm_resource_group" "rg" {
  location = module.global_variables.location
  name     = module.global_variables.rg_name
}
