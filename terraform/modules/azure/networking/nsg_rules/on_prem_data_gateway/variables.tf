variable "nsg_rules" {
  description = "lista de regras de nsgs"
  type        = "list"
  default = [
    {
      name                       = "sql-access-outbound",
      description                = "Access to external SQL servers",
      protocol                   = "Tcp",
      priority                   = 110,
      direction                  = "Outbound",
      access                     = "Allow",
      source_port_range          = "*",
      source_address_prefix      = "*",
      destination_port_ranges    = ["1433", "11000-11999"],
      destination_address_prefix = "10.121.88.64/27" # TODO: variar o CIDR de destino por ambiente
    },
    {
      name                       = "http-access-outbound",
      description                = "Used for auto update",
      protocol                   = "Tcp",
      priority                   = 120,
      direction                  = "Outbound",
      access                     = "Allow",
      source_port_range          = "*",
      source_address_prefix      = "*",
      destination_port_ranges    = ["80"],
      destination_address_prefix = "Internet"
    },
    {
      name                       = "https-access-outbound",
      description                = "Used to communicate with Azure services",
      protocol                   = "Tcp",
      priority                   = 130,
      direction                  = "Outbound",
      access                     = "Allow",
      source_port_range          = "*",
      source_address_prefix      = "*",
      destination_port_ranges    = ["443"],
      destination_address_prefix = "Internet"
    },
    {
      name                       = "relay-amqp-access-outbound",
      description                = "Used to communicate with Azure Relay thru AMQP",
      protocol                   = "Tcp",
      priority                   = 140,
      direction                  = "Outbound",
      access                     = "Allow",
      source_port_range          = "*",
      source_address_prefix      = "*",
      destination_port_ranges    = ["5671-5672"],
      destination_address_prefix = "Internet"
    },
    {
      name                       = "relay-tcp-access-outbound",
      description                = "Used to communicate with Azure Relay thru TCP",
      protocol                   = "Tcp",
      priority                   = 150,
      direction                  = "Outbound",
      access                     = "Allow",
      source_port_range          = "*",
      source_address_prefix      = "*",
      destination_port_ranges    = ["9350-9354"],
      destination_address_prefix = "Internet"
    }
  ]
}
