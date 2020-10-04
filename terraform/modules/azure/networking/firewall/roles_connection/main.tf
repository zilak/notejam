resource "azurerm_firewall_network_rule_collection" "rule_collection" {
  for_each            = { for collection in var.collections : collection.name => collection }
  action              = each.value.action
  azure_firewall_name = var.firewall_name
  name                = each.key
  priority            = each.value.priority
  resource_group_name = var.rg_name

  dynamic "rule" {
    for_each = { for rules in each.value.rule : rules.name => rules }
    content {
      name                  = rule.key
      source_addresses      = rule.value.source_addresses
      destination_ports     = rule.value.destination_ports
      destination_addresses = rule.value.destination_addresses
      protocols             = rule.value.protocols
    }
  }
}

resource "azurerm_firewall_application_rule_collection" "fqnds" {
  for_each            = { for collection in var.fqdns_collections : collection.name => collection }
  action              = each.value.action
  azure_firewall_name = var.firewall_name
  name                = each.key
  priority            = each.value.priority
  resource_group_name = var.rg_name

  dynamic "rule" {
    for_each = { for rules in each.value.rule : rules.name => rules }
    content {
      /*name = rule.key
      source_addresses = rule.value.source_addresses
      destination_ports = rule.value.destination_ports
      destination_addresses = rule.value.destination_addresses
      protocols = rule.value.protocols*/

      name             = rule.key
      source_addresses = rule.value.source_addresses
      target_fqdns     = rule.value.target_fqdns
      protocol {
        type = "Https"
        port = "443"
      }
    }
  }
}
