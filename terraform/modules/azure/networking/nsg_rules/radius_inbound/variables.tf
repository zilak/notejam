variable "rule_inbound_name" {
  type    = "string"
  default = "vpn-to-radius-inbound"
}


variable "rule_pritority" {
  type    = "string"
  default = "250"
}


variable "rule_protocol" {
  type        = "string"
  description = "Tcp or Udp"
  default     = "*"
}

variable "rule_source_port" {
  type    = "string"
  default = "*"
}

variable "rule_dest_ports" {
  type    = list
  default = ["1645", "1646", "1812", "1813"]
}









