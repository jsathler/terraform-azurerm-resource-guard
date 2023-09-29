locals {
  rguard_subscription_id  = ""
  prd_subscription_id     = ""
  devtest_subscription_id = ""
}

provider "azurerm" {
  features {}
  # subscription_id = local.rguard_subscription_id
}

provider "azurerm" {
  features {}
  # subscription_id = local.prd_subscription_id
  alias = "prd"
}

provider "azurerm" {
  features {}
  # subscription_id = local.devtest_subscription_id
  alias = "devtest"
}

resource "azurerm_resource_group" "default" {
  name     = "resourceguard-sample-rg"
  location = "northeurope"
}

resource "azurerm_resource_group" "prd" {
  name     = "resourceguard-prd-sample-rg"
  location = "northeurope"
  provider = azurerm.prd
}

resource "azurerm_resource_group" "devtest" {
  name     = "resourceguard-devtest-sample-rg"
  location = "northeurope"
  provider = azurerm.devtest
}

module "prd-rsv" {
  source              = "jsathler/recovery-services-vault/azurerm"
  resource_group_name = azurerm_resource_group.prd.name
  location            = azurerm_resource_group.prd.location

  providers = {
    azurerm = azurerm.prd
  }

  vault = {
    name         = "prd"
    immutability = "Disabled"
  }
}

module "devtest-rsv" {
  source              = "jsathler/recovery-services-vault/azurerm"
  resource_group_name = azurerm_resource_group.devtest.name
  location            = azurerm_resource_group.devtest.location

  providers = {
    azurerm = azurerm.devtest
  }

  vault = {
    name         = "devtest"
    immutability = "Disabled"
  }
}


module "prd-rguard" {
  source              = "../"
  resource_group_name = azurerm_resource_group.default.name
  location            = azurerm_resource_group.default.location

  name                 = "prd"
  disabled_protections = { get_security_pin = true }
  vault_ids            = { devtest-rsv = module.devtest-rsv.rsv_id, prd-rsv = module.prd-rsv.rsv_id }
}
