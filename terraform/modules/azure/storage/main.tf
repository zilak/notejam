resource "azurerm_storage_account" "storage_account" {
  account_replication_type = var.replication
  account_tier             = var.tier
  location                 = var.location
  name                     = var.name
  resource_group_name      = var.rg_name
}

resource "azurerm_storage_container" "containers" {
  for_each             = { for container in var.containers : container => container }
  name                 = each.key
  storage_account_name = azurerm_storage_account.storage_account.name
}