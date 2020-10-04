variable "rule_outbound_name" {
  type    = "string"
  default = "dc-outbound"
}


variable "rule_pritority" {
  type    = "string"
  default = "400"
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
  type    = "list"
  default = ["53", "88", "123", "135", "136", "137", "138", "139", "389", "445", "464", "636", "3268-3269", "9000-65500"]
}








