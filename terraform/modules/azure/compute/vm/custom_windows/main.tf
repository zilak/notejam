######### The difference between this (windows_2) and (windows_3) is that this creates with a Managed Identity
//TODO merge todos os windows e user dynamic blocks para diferenciar


module "global_variables" {
  source = "../../../../global_variables"
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




resource "azurerm_network_interface" "nic" {
  count               = length(var.virtual_machines)
  name                = "${lookup(var.virtual_machines[count.index], "vm_name")}-NI001"
  location            = data.azurerm_resource_group.rg.location
  resource_group_name = data.azurerm_resource_group.rg.name

  ip_configuration {
    name                          = "${lookup(var.virtual_machines[count.index], "vm_name")}-ipconfig"
    subnet_id                     = data.azurerm_subnet.subnet.id
    private_ip_address_allocation = lookup(var.virtual_machines[count.index], "ip_allocation")
    private_ip_address            = lookup(var.virtual_machines[count.index], "private_ip")
  }
  tags = {
    ChangeDate      = formatdate("YYYYMMDD", timestamp())
    CostCenter      = var.tags.CostCenter
    Environment     = var.tags.Environment
    ExpirationDate  = var.tags.ExpirationDate
    Owner           = var.tags.Owner
    RunningInterval = var.tags.RunningInterval
    ServiceType     = module.global_variables.network_service_type
    Solution        = var.tags.Solution
  }

  lifecycle {
    ignore_changes = ["ip_configuration"]
  }
}

resource "azurerm_availability_set" "as" {
  name                = "${lookup(var.virtual_machines[0], "vm_name")}-AS001"
  location            = data.azurerm_resource_group.rg.location
  resource_group_name = data.azurerm_resource_group.rg.name
  managed             = true
  tags = {
    ChangeDate      = formatdate("YYYYMMDD", timestamp())
    CostCenter      = var.tags.CostCenter
    Environment     = var.tags.Environment
    ExpirationDate  = var.tags.ExpirationDate
    Owner           = var.tags.Owner
    RunningInterval = var.tags.RunningInterval
    ServiceType     = module.global_variables.compute_service_type
    Solution        = var.tags.Solution
  }
}

resource "azurerm_virtual_machine" "vm" {
  count                 = length(var.virtual_machines)
  name                  = lookup(var.virtual_machines[count.index], "vm_name")
  location              = data.azurerm_resource_group.rg.location
  network_interface_ids = [azurerm_network_interface.nic.*.id[count.index]]
  resource_group_name   = data.azurerm_resource_group.rg.name
  vm_size               = lookup(var.virtual_machines[count.index], "vm_size")
  # license_type          = "Windows_Server"

  os_profile {
    admin_username = "test12345"
    computer_name  = lookup(var.virtual_machines[count.index], "vm_name")
    admin_password = "test12345A@!"
  }

  os_profile_windows_config {
    enable_automatic_upgrades = "false"
    provision_vm_agent        = true
  }

  storage_image_reference {
    publisher = var.os_info["os_publisher"]
    offer     = var.os_info["os_offer"]
    sku       = var.os_info["os_sku"]
    version   = var.os_info["os_version"]
  }

  storage_os_disk {
    name              = "${lookup(var.virtual_machines[count.index], "vm_name")}-OSM01"
    create_option     = var.os_disk_create_option
    managed_disk_type = lookup(var.virtual_machines[count.index], "os_disk_type")

  }

  availability_set_id              = azurerm_availability_set.as.id
  delete_os_disk_on_termination    = true
  delete_data_disks_on_termination = true


  tags = {
    ChangeDate      = formatdate("YYYYMMDD", timestamp())
    CostCenter      = var.tags.CostCenter
    Environment     = var.tags.Environment
    ExpirationDate  = var.tags.ExpirationDate
    Owner           = var.tags.Owner
    RunningInterval = var.tags.RunningInterval
    ServiceType     = module.global_variables.compute_service_type
    Solution        = var.tags.Solution
  }
  depends_on = [azurerm_network_interface.nic]

  lifecycle {
    ignore_changes = ["os_profile"]
  }
}

resource "azurerm_managed_disk" "data_disks" {
  count = length(var.data_disks)

  name                 = "${lookup(var.data_disks[count.index], "vm_name")}-DDMS${lookup(var.data_disks[count.index], "disk_lun")}"
  create_option        = lookup(var.data_disks[count.index], "disk_create_option")
  location             = data.azurerm_resource_group.rg.location
  resource_group_name  = data.azurerm_resource_group.rg.name
  storage_account_type = lookup(var.data_disks[count.index], "disk_sku")
  disk_size_gb         = lookup(var.data_disks[count.index], "disk_size")
  tags = {
    ChangeDate      = formatdate("YYYYMMDD", timestamp())
    CostCenter      = var.tags.CostCenter
    Environment     = var.tags.Environment
    ExpirationDate  = var.tags.ExpirationDate
    Owner           = var.tags.Owner
    RunningInterval = var.tags.RunningInterval
    ServiceType     = module.global_variables.compute_service_type
    Solution        = var.tags.Solution
  }

  depends_on = [azurerm_virtual_machine.vm]
}

resource "azurerm_virtual_machine_data_disk_attachment" "data_disk_attach" {
  count              = length(var.data_disks)
  caching            = lookup(var.data_disks[count.index], "disk_caching")
  lun                = lookup(var.data_disks[count.index], "disk_lun")
  managed_disk_id    = azurerm_managed_disk.data_disks.*.id[count.index]
  virtual_machine_id = lookup(zipmap(azurerm_virtual_machine.vm.*.name, azurerm_virtual_machine.vm.*.id), lookup(var.data_disks[count.index], "vm_name"))

  depends_on = [azurerm_managed_disk.data_disks]
}
/*
data "azurerm_recovery_services_vault" "rsv" {
  name                = var.rsv_name
  resource_group_name = var.rsv_rg_name
}

data "azurerm_recovery_services_protection_policy_vm" "rsv_policy" {
  count               = length(var.virtual_machines)
  name                = lookup(var.virtual_machines[count.index],"backup_policy")
  recovery_vault_name = data.azurerm_recovery_services_vault.rsv.name
  resource_group_name = data.azurerm_recovery_services_vault.rsv.resource_group_name
}

resource "azurerm_recovery_services_protected_vm" "rsv_protected" {
  count               = length(var.virtual_machines)
  resource_group_name = data.azurerm_recovery_services_vault.rsv.resource_group_name
  recovery_vault_name = data.azurerm_recovery_services_vault.rsv.name
  source_vm_id        = azurerm_virtual_machine.vm.*.id[count.index]
  backup_policy_id    = data.azurerm_recovery_services_protection_policy_vm.rsv_policy.*.id[count.index]

  depends_on = [data.azurerm_recovery_services_protection_policy_vm.rsv_policy]
}*/

# Get log analytics workspace ID
data azurerm_log_analytics_workspace "log_workspace" {
  name                = var.log_workspace
  resource_group_name = var.log_rg
}

resource "azurerm_virtual_machine_extension" "vm_logs" {
  count                = length(var.virtual_machines)
  location             = data.azurerm_resource_group.rg.location
  name                 = "${lookup(var.virtual_machines[count.index], "vm_name")}-Logextension"
  publisher            = "Microsoft.EnterpriseCloud.Monitoring"
  resource_group_name  = data.azurerm_resource_group.rg.name
  type                 = "MicrosoftMonitoringAgent"
  type_handler_version = "1.0"
  virtual_machine_name = lookup(var.virtual_machines[count.index], "vm_name")
  settings             = <<SETTINGS
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

  depends_on = [azurerm_virtual_machine.vm, azurerm_virtual_machine_data_disk_attachment.data_disk_attach]
}