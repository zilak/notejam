
variable "os_disk_create_option" {
  type    = "string"
  default = "FromImage"
}

variable "extension_publisher" {
  type    = "string"
  default = "Microsoft.Compute"
}

variable "extension_type" {
  type    = "string"
  default = "CustomScriptExtension"
}

variable "extension_type_handler" {
  type    = "string"
  default = "1.9"
}

variable "extension_command" {
  type    = "string"
  default = ""
}

variable "kv_mi_secret_name" {
  type    = "string"
  default = "null"
}

variable "kv_secret_script" {
  type    = "string"
  default = ""
}
