variable "dns_server" {
  type    = "list"
  default = []
}

variable "spoke_vnet_peering" {
  type    = "list"
  default = null
}

variable "hub_vnet_peering" {
  type    = "list"
  default = null
}



variable "name" {
  type    = "string"
  default = null
}

variable "spoke_vnet_peering_config" {
  type = "map"
  default = {
    vnet_access       = true,
    forwarded_traffic = true,
    gateway_transit   = false,
    remote_gateway    = true
  }
}

variable "hub_vnet_peering_config" {
  type = "map"
  default = {
    vnet_access       = true,
    forwarded_traffic = true,
    gateway_transit   = true,
    remote_gateway    = false
  }
}
