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

variable "rule_source_address" {
  type = "list"
}

variable "rule_dest_address" {
  type = "list"
}
