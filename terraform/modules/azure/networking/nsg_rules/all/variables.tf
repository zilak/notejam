variable "rule_inbound_name" {
  type    = "string"
  default = "all-inbound-deny"
}

variable "rule_outbound_name" {
  type    = "string"
  default = "all-outbound-deny"
}

variable "rule_pritority" {
  type    = "string"
  default = "4096"
}

variable "rule_access" {
  type        = "string"
  description = "Allow or deny"
  default     = "Deny"
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

variable "rule_source_address" {
  type    = "string"
  default = "*"
}

variable "rule_dest_port" {
  type    = "string"
  default = "*"
}

variable "rule_dest_address" {
  type    = "string"
  default = "*"
}







