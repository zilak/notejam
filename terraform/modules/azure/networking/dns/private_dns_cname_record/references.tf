variable "private_dns_name" {
  type        = string
  description = "Private DNS Zone name"
}

variable "private_dns_rg_name" {
  type        = string
  description = "Private DNS Zone resouce group name"
}

variable "cname_record_name" {
  type        = string
  description = "A record name"
}

variable "record" {
  type        = string
  description = "IP Address of the recod name"
}