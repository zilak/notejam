variable "sql_server" {
  type    = string
  default = "notejamdevsql"
}

variable "db_name" {
  type    = string
  default = "notejamdev"
}

variable "privatelink_dns" {
  type    = string
  default = "privatelink.database.windows.net"
}