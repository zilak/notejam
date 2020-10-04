provider "azurerm" {
  features {}
}

module "global_variables" {
  source = "../global_variables"
}

module "vnet" {
  source = "../../../../modules/azure/networking/network"

  location           = module.global_variables.location
  nsg_rules          = []
  rg_name            = module.global_variables.rg_name
  subnets            = var.subnets
  tags               = {}
  vnet_address_space = ["10.0.0.0/23"]
  vnet_name          = module.global_variables.vnet_name
}