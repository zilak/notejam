provider "azurerm" {
  features {}
}

module "global_variables" {
  source = "../global_variables"
}

module "sqlserver" {
  source                  = "../../../../modules/azure/databases/sqlserver"
  sql_server              = var.sql_server
  rg_name                 = module.global_variables.rg_name
  db_name                 = var.db_name
  kv_name                 = module.global_variables.kv_name
  kv_password_secret_name = "password"
  kv_rg_name              = module.global_variables.rg_name
  kv_username_secret_name = "username"
  location                = module.global_variables.location

}

module "private_endpoint" {
  source                         = "../../../../modules/azure/networking/private_endpoint"
  connection_name                = "${var.sql_server}-connection"
  location                       = module.global_variables.location
  name                           = "${var.sql_server}-pe"
  private_connection_resource_id = module.sqlserver.resource_id
  rg_name                        = module.global_variables.rg_name
  subnet_name                    = "notejamvnetdev-pe"
  subnet_rg_name                 = module.global_variables.rg_name
  subresource_names              = ["sqlServer"]
  vnet_name                      = "notejamvnetdev"
}

module "dns_a_record_privatelink" {
  source = "../../../../modules/azure/networking/dns/private_dns_a_record"

  a_record_name       = var.sql_server
  ip_address          = module.private_endpoint.private_ip_address
  private_dns_name    = var.privatelink_dns
  private_dns_rg_name = module.global_variables.rg_name
  vnet_name           = module.global_variables.vnet_name
}

