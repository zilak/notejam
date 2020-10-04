
variable "kv_mi_secret_name" {
  type    = "string"
  default = "null"
}

variable "kv_secret_script" {
  type    = "string"
  default = ""
}

variable "os_disk" {
  type = map
  default = {
    storage_account_type = "Standard_LRS"
    caching              = "ReadWrite"
  }
}

variable "capacity" {
  type = map
  default = {
    default = 2
    maximum = 4
    minimum = 1
  }
}

variable "scalerule" {
  type = map
  default = {
    rule1 = {
      metric_name      = "Percentage CPU"
      time_grain       = "PT1M"
      statistic        = "Average"
      time_window      = "PT5M"
      time_aggregation = "Average"
      operator         = "GreaterThan"
      threshold        = 75
      direction        = "Increase"
      type             = "ChangeCount"
      value            = "1"
      cooldown         = "PT1M"
    }
    rule2 = {
      metric_name      = "Percentage CPU"
      time_grain       = "PT1M"
      statistic        = "Average"
      time_window      = "PT5M"
      time_aggregation = "Average"
      operator         = "LessThan"
      threshold        = 25
      direction        = "Decrease"
      type             = "ChangeCount"
      value            = "1"
      cooldown         = "PT1M"
    }
  }

}