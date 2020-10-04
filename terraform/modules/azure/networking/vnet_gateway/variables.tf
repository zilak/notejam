variable "bgp" {
  type    = "string"
  default = "false"
}

variable "active_active" {
  type    = "string"
  default = "false"
}

variable "vnet_config" {
  type    = "string"
  default = "vnetGatewayConfig"
}

variable "vpn_client_address_space" {
  type    = list
  default = []
}

variable "radius_server_address" {
  type    = string
  default = ""
}

variable "kv_name" {
  type    = string
  default = ""
}

variable "kv_rg_name" {
  type    = string
  default = ""
}

variable "kv_secret_name" {
  type    = string
  default = ""
}

variable "vpn_client_protocols" {
  type    = list
  default = []
}