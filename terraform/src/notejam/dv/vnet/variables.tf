variable "subnets" {
  type = "list"
  default = [
    { subnet_name = "app", subnet_address_space = "10.0.0.0/26", service_endpoints = [], enable_private_endpoint = "false", enable_private_link = "false", delegation = [] },
    { subnet_name = "pe", subnet_address_space = "10.0.0.64/26", service_endpoints = [], enable_private_endpoint = "true", enable_private_link = "true", delegation = [] },
    { subnet_name = "agw", subnet_address_space = "10.0.0.128/26", service_endpoints = [], enable_private_endpoint = "true", enable_private_link = "true", delegation = [] }
  ]
}