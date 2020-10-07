variable "frontdoor_name" {
  type    = string
  default = "notejamfd"
}
variable "backend" {
  type = list
  default = [
    { name = "dev", address = "51.138.51.219" }
  ]
}