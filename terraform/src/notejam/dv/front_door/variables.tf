variable "frontdoor_name" {
  type    = string
  default = "notejamfd"
}
variable "backend" {
  type = list
  default = [
    { name = "dev", address = "51.145.181.18" }
  ]
}