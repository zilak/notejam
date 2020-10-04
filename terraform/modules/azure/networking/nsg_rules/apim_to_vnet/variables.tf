
variable "rule_pritority" {
  type    = "string"
  default = "4005"
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
  default = "3443"
}

variable "rule_source_address" {
  type    = "string"
  default = "ApiManagement"
}

variable "rule_dest_address" {
  type    = "string"
  default = "VirtualNetwork"
}

variable "rule_direction" {
  type    = "string"
  default = "inbound"
}








