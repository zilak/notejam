variable "rg_name" {
  type        = "string"
  description = "Resource Group name"
}

variable "nsg_name" {
  type        = "string"
  description = "nsg name"
}

variable "subnet_scope" {
  type        = "string"
  description = "subnet address space in CIDR format"
}
