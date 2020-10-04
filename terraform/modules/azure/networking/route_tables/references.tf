
variable "rg_name" {
  type = "string"
}




variable "route_tables" {
  type = "list"
}

variable "location" {
  type = "string"
}

variable "tags" {
  type = map
}

variable "vnet_name" {
  type = string
}
/*  
  variable "resource_group_name" {
  type        = "string"
  default     = null
}  
 */
