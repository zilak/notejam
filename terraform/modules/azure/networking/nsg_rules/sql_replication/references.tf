variable "location" {
  type        = "string"
  description = "Specify a location"
}

variable "rg_name" {
  type        = "string"
  description = "Resource Group name"
}

variable "nsg_name" {
  type        = "string"
  description = "nsg name"
}

variable "rule_access" {
  type        = "string"
  description = "allow or deny"
  default     = "allow"
}

variable "local_address" {
  type = "string"
}

variable "remote_address" {
  type = "list"
}
