variable "probe_interval_in_seconds" {
  type    = "string"
  default = "10"
}
variable "probe_name" {
  type    = "string"
  default = "lb-cdc-running-probe"
}
variable "probe_port" {
  type    = number
  default = 80
}
variable "probe_protocol" {
  type    = "string"
  default = "Tcp"
}
variable "probe_number_of_probes" {
  type    = number
  default = 3
}

variable "BackEndAddressPoolName" {
  type    = "string"
  default = "BackEndAddressPool"
}

variable "lb_name" {
  type    = "string"
  default = "Load_Balancer"
}
variable "lb_rule_protocol" {
  type    = "string"
  default = "Tcp"
}
variable "lb_rule_name" {
  type    = "string"
  default = "LB_Rule"
}
variable "lb_enable_floating_ip" {
  type    = "string"
  default = "true"
}

variable "lb_rule_load_distribution" {
  type    = "string"
  default = "Default"
}




