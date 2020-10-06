locals {
  frontend_endpoint_name = "notejamfd-azurefd-net"
  loadbalancer_name      = "loadbalancerName"
  health_probe_name      = "healthprobename"
}

resource "azurerm_frontdoor" "frontdoor" {
  enforce_backend_pools_certificate_name_check = false
  name                                         = var.frontdoor_name
  resource_group_name                          = var.rg_name
  friendly_name                                = var.frontdoor_name
  routing_rule {
    accepted_protocols = ["Http", "Https"]
    frontend_endpoints = [local.frontend_endpoint_name]
    name               = "routedev"
    patterns_to_match  = ["/*"]
    forwarding_configuration {
      backend_pool_name   = "dev"
      forwarding_protocol = "HttpOnly"
    }
  }

  dynamic "backend_pool" {
    for_each = { for backend in var.backend : backend.name => backend }
    content {
      health_probe_name   = local.health_probe_name
      load_balancing_name = local.loadbalancer_name
      name                = backend_pool.key
      backend {
        address     = backend_pool.value.address
        host_header = backend_pool.value.address
        http_port   = 80
        https_port  = 443
      }
    }
  }

  backend_pool_health_probe {
    name                = local.health_probe_name
    interval_in_seconds = 255
    path                = "/signin/"
    probe_method        = "HEAD"
  }
  backend_pool_load_balancing {
    name = local.loadbalancer_name
  }
  frontend_endpoint {
    custom_https_provisioning_enabled = false
    host_name                         = "${var.frontdoor_name}.azurefd.net"
    name                              = local.frontend_endpoint_name
  }


}