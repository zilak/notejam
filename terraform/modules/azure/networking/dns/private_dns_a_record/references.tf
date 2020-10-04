variable "private_dns_name" {
  type        = string
  description = "Private DNS Zone name"
}

variable "private_dns_rg_name" {
  type        = string
  description = "Private DNS Zone resouce group name"
}

variable "a_record_name" {
  type        = string
  description = "A record name"
}

variable "ip_address" {
  type        = string
  description = "IP Address of the recod name"
}

variable "vnet_name" {
  type = string
}