

variable "subnet_name" {
  type        = string
  description = "Subnet  name"
}

variable "subnet_rg_name" {
  type        = string
  description = "Subnet Resource Group name"
}

variable "vnet_name" {
  type        = string
  description = "VNet name"
}

variable "name" {
  type        = string
  description = "Private Endpoint name"
}

variable "location" {
  type        = string
  description = "Private Endpoint location"
}

variable "rg_name" {
  type        = string
  description = "Private Endpoint resource group name"
}

variable "connection_name" {
  type        = string
  description = "Connection name of the private link"
}

variable "private_connection_resource_id" {
  type        = string
  description = "Resource ID of the resource to create the private endpoint (eg: Cosmos DB Account, Storage Account id)"
}

variable "subresource_names" {
  type        = list
  description = "Sub resource names for the private link, eg: for Cosmos DB ->  Document DB the value is [''Sql'']. Go to https://docs.microsoft.com/en-us/azure/private-link/private-endpoint-overview#private-link-resource to get all the sub resource"
}