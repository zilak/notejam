variable "replication" {
  type    = string
  default = "GZRS"
}

variable "name" {
  type    = string
  default = "notejamstorage"
}

variable "containers" {
  type    = list
  default = ["images"]
}

variable "tier" {
  type    = string
  default = "Standard"
}