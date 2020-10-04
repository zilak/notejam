
data "azurerm_resource_group" "rg" {
  name = var.rg_name
}

data "azurerm_client_config" "current" {

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
  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = data.azurerm_client_config.current.object_id

    key_permissions = [
      "create",
      "get",
      "list",
    ]

    secret_permissions = [
      "set",
      "get",
      "delete",
      "list",
    ]
  }
}

resource "azurerm_key_vault_secret" "example" {
  for_each     = var.keyvault_secret
  name         = each.key
  value        = each.value
  key_vault_id = azurerm_key_vault.key_vault.id
}