
data "azurerm_resource_group" "rg" {
  name = var.rg_name
}

resource "azurerm_log_analytics_workspace" "loganalytics" {
  name                = var.name
  location            = var.location
  resource_group_name = data.azurerm_resource_group.rg.name
  sku                 = var.sku

  tags = {
  }

  // TODO if retention_in_day is defined it gives erro
  //
  //  retention_in_days   = tonumber(var.retention_in_days)
}

output "id" {
  value = azurerm_log_analytics_workspace.loganalytics.id
}

output "primary_shared_key" {
  value = azurerm_log_analytics_workspace.loganalytics.primary_shared_key
}

output "secondary_shared_key" {
  value = azurerm_log_analytics_workspace.loganalytics.secondary_shared_key
}

output "workspace_id" {
  value = azurerm_log_analytics_workspace.loganalytics.workspace_id
}

output "portal_url" {
  value = azurerm_log_analytics_workspace.loganalytics.portal_url
}
