variable "rule_inbound_name" {
  type    = "string"
  default = "sql-replication-inbound"
}

variable "rule_outbound_name" {
  type    = "string"
  default = "sql-replication-outbound"
}


variable "rule_pritority" {
  type    = "string"
  default = "310"
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
  default = ["1433", "5022", "11000-11999"]
}









