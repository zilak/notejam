
data "azurerm_key_vault" "kv" {
  name                = var.kv_name
  resource_group_name = var.kv_rg_name
}

data "azurerm_key_vault_secret" "kv_secret_username" {
  name         = var.kv_username_secret_name
  key_vault_id = data.azurerm_key_vault.kv.id
}

data "azurerm_key_vault_secret" "kv_secret_password" {
  name         = var.kv_password_secret_name
  key_vault_id = data.azurerm_key_vault.kv.id
}

resource "azurerm_sql_server" "sql_server" {
  administrator_login          = data.azurerm_key_vault_secret.kv_secret_username.value
  administrator_login_password = data.azurerm_key_vault_secret.kv_secret_password.value
  location                     = var.location
  name                         = var.sql_server
  resource_group_name          = var.rg_name
  version                      = "12.0"
}

resource "azurerm_sql_database" "database" {
  location            = var.location
  name                = var.db_name
  resource_group_name = azurerm_sql_server.sql_server.resource_group_name
  server_name         = azurerm_sql_server.sql_server.name
  edition             = "Basic"
}

output "resource_id" {
  value = azurerm_sql_server.sql_server.id
}