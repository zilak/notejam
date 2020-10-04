provider "azurerm" {
  features {}
}

module "scaleset" {
  source                  = "../../../../modules/azure/compute/vm/scaleset_windows"
  image_id                = "/subscriptions/a38fac22-fdcb-4f4d-a843-e162d0f2f420/resourceGroups/nordrg/providers/Microsoft.Compute/images/notejamimage"
  instances               = 2
  kv_name                 = "jonhyI001"
  kv_password_secret_name = "LAPW2KIAC"
  kv_rg_name              = "RGCM1QMSCRT002"
  kv_username_secret_name = "LAUW2KIAC"
  location                = "westeurope"
  log_rg                  = "nordrg"
  log_workspace           = "lognorddev"
  rg_name                 = "nordrg"
  scale_set_name          = "notejamdev"
  sku                     = "Standard_B2s"
  subnet_name             = "default"
  subnet_rg_name          = "ola13"
  tags                    = {}
  vnet_name               = "ola13-vnet"
}