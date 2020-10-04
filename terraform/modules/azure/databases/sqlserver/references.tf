########## key vault vars #####################

variable "kv_username_secret_name" {
  type = "string"
}

variable "kv_password_secret_name" {
  type = "string"
}

variable "kv_name" {
  type = "string"
}

variable "kv_rg_name" {
  type = "string"
}



variable "location" {
  type = "string"
}

########## sql vars #####################

variable "rg_name" {
  type = "string"
}

variable "sql_server" {
  type = "string"
}

variable "db_name" {
  type = string
}