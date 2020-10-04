########## RG vars #####################

variable "rg_name" {
  type = "string"
}

########## Availability set vars #####################



########## VM vars #####################
variable "virtual_machines" {
  type = "list"
}

variable "os_info" {
  type = "map"
}

variable "data_disks" {
  type = "list"
}



########## network vars #####################

variable "vnet_name" {
  type = "string"
}

variable "subnet_name" {
  type = "string"
}


variable "subnet_rg_name" {
  type = "string"
}

variable "location" {
  type = "string"
}

variable "tags" {
  type = "map"
}

#### Log analytics ###

variable "log_workspace" {
  type = "string"
}

variable "log_rg" {
  type = "string"
}