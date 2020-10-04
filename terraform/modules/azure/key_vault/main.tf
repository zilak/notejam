#Deploy de um key vault integrado numa VNET

module "global_variables" {
  source = "../../../global_variables"
}

data "azurerm_resource_group" "rg" {
  name = var.rg_name
}

data "azurerm_client_config" "current" {

}

// Estes 2 blocos estão preparados para serem executados por pipelines. Como o objetivo é a criação dos KVs manualmente, os mesmos foram comentados
// Objetivo dos blocos é ir buscar o tenantID
/*
data "azurerm_key_vault" "global_kv" {
  name                = var.kv_global_name
  resource_group_name = var.kv_global_rg_name
}

data "azurerm_key_vault_secret" "global_kv_secret" {
  name          = var.tenant_secret_name
  key_vault_id  = data.azurerm_key_vault.global_kv.id
}
*/

data "azurerm_subnet" "subnet" {
  count                = length(var.subnets)
  name                 = lookup(var.subnets[count.index], "subnet_name")
  virtual_network_name = lookup(var.subnets[count.index], "vnet_name")
  resource_group_name  = lookup(var.subnets[count.index], "subnet_rg_name")

}


resource "azurerm_key_vault" "key_vault" {
  name                            = var.kv_name
  location                        = data.azurerm_resource_group.rg.location
  resource_group_name             = data.azurerm_resource_group.rg.name
  enabled_for_disk_encryption     = var.kv_enabled_disk_encryption
  enabled_for_deployment          = var.kv_enabled_deployment
  enabled_for_template_deployment = var.kv_enabled_template_deployment
  #tenant_id                       = data.azurerm_key_vault_secret.global_kv_secret.value
  tenant_id = data.azurerm_client_config.current.tenant_id
  sku_name  = var.kv_sku

  network_acls {
    default_action             = var.kv_acl_action
    bypass                     = var.kv_acl_bypass
    virtual_network_subnet_ids = data.azurerm_subnet.subnet.*.id
    ip_rules                   = module.global_variables.proxy_ip
  }

  tags = {
    ChangeDate      = formatdate("YYYYMMDD", timestamp())
    CostCenter      = var.tags.CostCenter
    Environment     = var.tags.Environment
    ExpirationDate  = var.tags.ExpirationDate
    Owner           = var.tags.Owner
    RunningInterval = var.tags.RunningInterval
    ServiceType     = module.global_variables.keyvault_service_type
    Solution        = var.tags.Solution
  }

}




resource "azurerm_key_vault_access_policy" "kv_access_policies" {
  count        = length(var.kv_access_policies)
  key_vault_id = azurerm_key_vault.key_vault.id
  tenant_id    = data.azurerm_client_config.current.tenant_id
  #tenant_id           = data.azurerm_key_vault_secret.global_kv_secret.value
  object_id               = var.kv_access_policies[count.index].object_id
  key_permissions         = var.kv_access_policies[count.index].key_permissions
  certificate_permissions = var.kv_access_policies[count.index].certificate_permissions
  storage_permissions     = var.kv_access_policies[count.index].storage_permissions
  secret_permissions      = var.kv_access_policies[count.index].secret_permissions
}
