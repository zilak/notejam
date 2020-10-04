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


