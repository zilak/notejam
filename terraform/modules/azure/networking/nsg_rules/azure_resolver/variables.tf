
variable "rule_pritority" {
  type    = "string"
  default = "2100"
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

variable "rule_dest_port" {
  type    = "string"
  default = "*"
}

variable "rule_dest_address" {
  type    = "string"
  default = "168.63.129.16"
}








