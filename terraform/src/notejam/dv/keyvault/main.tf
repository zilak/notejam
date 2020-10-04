provider "azurerm" {
  features {}
}
module "global_variables" {
  source = "../global_variables"
}

module "keyvault" {
  source          = "../../../../modules/azure/security/key_vault"
  keyvault_secret = module.global_variables.kv_secrets
  kv_name         = module.global_variables.kv_name
  location        = module.global_variables.location
  rg_name         = module.global_variables.rg_name
}