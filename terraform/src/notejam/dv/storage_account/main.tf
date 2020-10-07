provider "azurerm" {
  features {}
}

module "global_variables" {
  source = "../global_variables"
}

module "storage_account" {
  source      = "../../../../modules/azure/storage"
  containers  = var.containers
  location    = module.global_variables.location
  name        = var.name
  replication = var.replication
  rg_name     = module.global_variables.rg_name
  tier        = var.tier
}