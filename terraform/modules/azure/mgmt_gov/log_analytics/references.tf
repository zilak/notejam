#Variables that must be define

variable "rg_name" {
  type        = "string"
  description = "Resource Group name"
}

variable "name" {
  type        = "string"
  description = "Log analytics name"
}


######################## Tagging vars #######################

variable "tags" {
  type = "map"
}

variable "location" {
  type = "string"
}

variable "sku" {
  type        = "string"
  description = "Specifies the Sku of the Log Analytics Workspace. Possible values are Free, PerNode, Premium, Standard, Standalone, Unlimited, and PerGB2018"
}

variable "retention_in_days" {
  type        = "string"
  default     = 30
  description = "The workspace data retention in days. Possible values range between 30 and 730"
}

