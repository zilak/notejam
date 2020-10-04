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
variable "kv_sku" {
  type = "string"
}

variable "kv_acl_bypass" {
  type        = "string"
  description = "Specifies which traffic can bypass the network rules. Possible values are AzureServices and None"
}

variable "kv_acl_action" {
  type        = "string"
  description = "he Default Action to use when no rules match from ip_rules / virtual_network_subnet_ids. Possible values are Allow and Deny"
}

variable "kv_access_policies" {
  type        = "list"
  description = "https://www.terraform.io/docs/providers/azurerm/r/key_vault_access_policy.html"
}

variable "tags" {
  type = "map"
}

variable "location" {
  type = "string"
}

variable "subnets" {
  type = "list"
}
