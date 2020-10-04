########## rg vars #####################

variable "rg_name" {
  type        = "string"
  description = "Resource Group name"
}

########## vnet vars #####################

variable "vnet_name" {
  type        = "string"
  description = "The name of the virtual network. Changing this forces a new resource to be created"
}

variable "vnet_address_space" {
  type        = "list"
  description = "The address space that is used the virtual network. You can supply more than one address space. Changing this forces a new resource to be created"
}

########## subnet vars #####################

variable "subnets" {
  type = "list"
}

variable "nsg_rules" {
  type = "list"
}

variable "location" {
  type        = "string"
  description = "Specify a location"
}


################## Tagging vars ###############
variable "tags" {
  type = "map"
}