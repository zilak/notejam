
variable "tenant_secret_name" {
  type    = "string"
  default = "#{tenantid}#"
}
variable "kv_enabled_disk_encryption" {
  type        = bool
  default     = true
  description = "Boolean flag to specify whether Azure Disk Encryption is permitted to retrieve secrets from the vault and unwrap keys."
}

variable "kv_enabled_deployment" {
  type        = bool
  default     = true
  description = "Boolean flag to specify whether Azure Virtual Machines are permitted to retrieve certificates stored as secrets from the key vault."
}

variable "kv_enabled_template_deployment" {
  type        = bool
  default     = true
  description = "Boolean flag to specify whether Azure Resource Manager is permitted to retrieve secrets from the key vault."
}

variable "kv_sku" {
  type    = "string"
  default = "standard"
}