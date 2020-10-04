variable "rg_name" {
  type = "string"
}
variable "vm_names" {
  type    = "list"
  default = ["SVCM1PIANO003", "SVCM1PIANO004"]
}

variable "vnet_rg_name" {
  type = "string"
}
variable "subnet_id" {
  type = "string"
}
variable "vnet_name" {
  type = "string"
}

variable "location" {
  type = "string"
}

variable "lb_sku" {
  type = "string"
}

variable "lb_rule_frontend_port" {
  type = number
}
variable "lb_rule_backend_port" {
  type = number
}
variable "lb_rule_backend_address_pool_id" {
  type = number
}

variable "frontend_ip_configuration_name" {
  type = "string"
}

variable "tags" {
  type = "map"
}

variable "private_id_address" {
  type = "string"
}

variable "private_ip_address_allocation" {
  type = "string"
}

variable "Vm_NICs" {
  type = "list"
}

variable "backend_address_pool_id" {
  type = "string"
}
