variable "rule_inbound_name" {
  type    = "string"
  default = "sql-inbound"
}

variable "rule_outbound_name" {
  type    = "string"
  default = "sql-outbound"
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

variable "rule_dest_ports" {
  type    = "list"
  default = ["1433", "11000-11999"]
}









