
provider "azurerm" {
  features {}
}
data "azurerm_resource_group" "rg" {
  name = var.rg_name
}

data "azurerm_subnet" "subnet" {
  name                 = var.subnet_name
  virtual_network_name = var.vnet_name
  resource_group_name  = var.subnet_rg_name

  depends_on = [data.azurerm_resource_group.rg]
}

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

data azurerm_log_analytics_workspace "log_workspace" {
  name                = var.log_workspace
  resource_group_name = var.log_rg
}



resource "azurerm_windows_virtual_machine_scale_set" "scale_set" {
  admin_password      = data.azurerm_key_vault_secret.kv_secret_username.value
  admin_username      = data.azurerm_key_vault_secret.kv_secret_password.value
  instances           = var.instances
  location            = var.location
  name                = var.scale_set_name
  resource_group_name = var.rg_name
  sku                 = var.sku
  network_interface {
    name = "${var.scale_set_name}-nic"
    ip_configuration {

      name      = "${var.scale_set_name}-ipconfig"
      primary   = true
      subnet_id = data.azurerm_subnet.subnet.id
    }
  }
  os_disk {
    storage_account_type = var.os_disk.storage_account_type
    caching              = var.os_disk.caching
  }
  source_image_id = var.image_id


  extension {
    name                       = "logextension"
    publisher                  = "Microsoft.EnterpriseCloud.Monitoring"
    type                       = "MicrosoftMonitoringAgent"
    type_handler_version       = "1.0"
    auto_upgrade_minor_version = true
    settings                   = <<SETTINGS
  {
    "workspaceId": "${data.azurerm_log_analytics_workspace.log_workspace.workspace_id}"
  }
  SETTINGS
    // TODO changed this from keyvault to primary share key check the impact
    protected_settings = <<SETTINGS
  {
    "workspaceKey": "${data.azurerm_log_analytics_workspace.log_workspace.primary_shared_key}"
  }
  SETTINGS
  }


  lifecycle {
    ignore_changes = ["instances"]
  }
}

resource "azurerm_monitor_autoscale_setting" "main" {
  location            = var.location
  name                = "${var.scale_set_name}-config"
  resource_group_name = var.rg_name
  target_resource_id  = azurerm_windows_virtual_machine_scale_set.scale_set.id
  profile {
    name = "AutoScale"
    capacity {
      default = var.capacity.default
      maximum = var.capacity.maximum
      minimum = var.capacity.minimum
    }
    dynamic "rule" {
      for_each = var.scalerule
      content {

        metric_trigger {
          metric_name        = rule.value.metric_name
          metric_resource_id = azurerm_windows_virtual_machine_scale_set.scale_set.id
          operator           = rule.value.operator
          statistic          = rule.value.statistic
          threshold          = rule.value.threshold
          time_aggregation   = rule.value.time_aggregation
          time_grain         = rule.value.time_grain
          time_window        = rule.value.time_window
        }
        scale_action {

          cooldown  = rule.value.cooldown
          direction = rule.value.direction
          type      = rule.value.type
          value     = rule.value.value
        }
      }
    }
  }
}