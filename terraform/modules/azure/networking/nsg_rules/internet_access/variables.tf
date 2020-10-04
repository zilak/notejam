variable "rule_inbound_name" {
  type    = "string"
  default = "all-inbound-deny"
}

variable "rule_outbound_name" {
  type    = "string"
  default = "internet-outbound-allow"
}

variable "rule_priority" {
  type    = "string"
  default = "3000"
}

variable "rule_name" {
  type    = "string"
  default = null
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

variable "rule_source_address" {
  type    = "string"
  default = "*"
}

variable "rule_dest_port" {
  type    = "list"
  default = ["443", "80"]
}

variable "rule_dest_address" {
  type    = "string"
  default = "Internet"
}







