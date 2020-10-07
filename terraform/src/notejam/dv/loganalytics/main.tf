#Log Analtyics
provider "azurerm" {
  features {}
}
module "global_variables" {
  source = "../global_variables"
}

module "log_analytics" {
  source   = "../../../../modules/azure/mgmt_gov/log_analytics"
  name     = module.global_variables.log_analytics_name
  rg_name  = module.global_variables.rg_name
  location = module.global_variables.location
  tags     = {}
  sku      = var.sku
}