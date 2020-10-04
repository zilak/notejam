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
  description = "nsg to have access to azure cloud"
}

variable "rule_access" {
  type        = "string"
  description = "Allow or deny"
}

variable "rule_source_address" {
  type = "list"
}

variable "rule_direction" {
  type = "string"
}
