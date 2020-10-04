########## RG vars #####################

variable "rg_name" {
  type = "string"
}

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

########## Availability set vars #####################



########## VM vars #####################
variable "scale_set_name" {
  type = "string"
}

########## network vars #####################

variable "vnet_name" {
  type = "string"
}

variable "subnet_name" {
  type = "string"
}


variable "subnet_rg_name" {
  type = "string"
}

variable "location" {
  type = "string"
}

variable "tags" {
  type = "map"
}

#### Log analytics ###

variable "log_workspace" {
  type = "string"
}

variable "log_rg" {
  type = "string"
}

variable "image_id" {
  type        = string
  description = "Image ID of the Virtual Machine"
}

variable "instances" {
  type        = number
  description = "Scale set Instances"
}

variable "sku" {
  type        = string
  description = "Sku/Size scale set"
}