variable "vnet" {
  type = string
}
variable "rg_name" {
  type = string
}

variable "firewall_name" {
  type = string
}

variable "location" {
  type = string
}




variable "rules" {
  type = "list"
}



variable "rule_coll_name" {
  type = "string"
}
