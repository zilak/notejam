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

module "internet" {
  source              = "../../../../modules/azure/networking/nsg_rules/service_tag_to_service_tag_dest_ports"
  location            = module.global_variables.location
  nsg_name            = module.vnet.nsg_name[2]
  nsg_rule_name       = "agw"
  rg_name             = module.global_variables.rg_name
  rule_access         = "allow"
  rule_dest_address   = "*"
  rule_direction      = "inbound"
  rule_pritority      = "400"
  rule_source_address = "*"
  rule_dest_ports     = ["65200-65535", "80"]
}