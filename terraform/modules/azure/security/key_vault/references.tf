################# RG vars #######################
variable "rg_name" {
  type = "string"
}

################ Global Key Vault vars ################
/*variable "kv_global_name" {
  type    = "string"
}

variable "kv_global_rg_name" {
  type    = "string"
}
*/
################ Key Vault vars ################
variable "kv_name" {
  type = "string"
}


variable "location" {
  type = "string"
}

variable "keyvault_secret" {
  type = "map"
}
