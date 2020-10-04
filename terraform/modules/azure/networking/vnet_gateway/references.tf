variable "type" {
  type = "string"
}

variable "sku" {
  type = "string"
}

variable "rg_name" {
  type = "string"
}

variable "vnetgateway_name" {
  type = "string"
}

variable "location" {
  type    = "string"
  default = "westeurope"
}

variable "tags" {
  type = "map"
}

variable "subnet_name" {
  type = "string"
}

variable "vnet" {
  type = "string"
}


