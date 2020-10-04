variable "location" {
  type        = "string"
  description = "Specify a location"
}

variable "rg_name" {
  type        = "string"
  description = "Resource Group name"
}

variable "nsg_name" {
  type        = "list"
  description = "nsg name"
}

variable "rule_access" {
  type        = "string"
  description = "Allow or deny"
}

variable "rule_direction" {
  type        = "string"
  description = "Inbound or outbound"
}
