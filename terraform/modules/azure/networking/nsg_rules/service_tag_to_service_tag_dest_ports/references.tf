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
  description = "nsg list of each subnet"
}

variable "rule_access" {
  type        = "string"
  description = "Allow or deny"
}

variable "rule_direction" {
  type = "string"
}

variable "nsg_rule_name" {
  type = "string"
}

variable "rule_dest_address" {
  type = "string"
}

variable "rule_source_address" {
  type = "string"
}

variable "rule_pritority" {
  type = "string"
}