variable "rule_inbound_name" {
  type    = "string"
  default = "rdp-inbound"
}

variable "rule_outbound_name" {
  type    = "string"
  default = "rdp-outbound"
}


variable "rule_pritority" {
  type    = "string"
  default = "300"
}


variable "rule_protocol" {
  type        = "string"
  description = "Tcp or Udp"
  default     = "TCP"
}

variable "rule_source_port" {
  type    = "string"
  default = "*"
}

variable "rule_dest_port" {
  type    = "string"
  default = "3389"
}









