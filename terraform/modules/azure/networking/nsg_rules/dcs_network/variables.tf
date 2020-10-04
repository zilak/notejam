variable "rule_name" {
  type    = "string"
  default = "dc-to-secondary"
}


variable "rule_pritority" {
  type    = "string"
  default = "350"
}


variable "rule_protocol" {
  type        = "string"
  description = "Tcp or Udp"
  default     = "*"
}


# Variable with the ports from the client dc
variable "dc_client_port" {
  type    = "list"
  default = ["49152-65535", "53"]
}

variable "dc_server_port" {
  type    = "list"
  default = ["123", "135", "464", "49152-65535", "389", "636", "3268", "3269", "53", "88", "445", "138", "139", "136", "137"]
}





