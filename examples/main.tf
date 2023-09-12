provider "azurerm" {
  features {}
}

provider "azurerm" {
  features {}
  subscription_id = "e745b82b-10a2-4fd3-a85f-148f0f1d6132"
  alias           = "devtest"
}

provider "azurerm" {
  features {}
  subscription_id = "0783ffe8-281d-407a-8b7f-c61da7adb25a"
  alias           = "prd"
}

resource "azurerm_resource_group" "default" {
  name     = "resourceguard-sample-rg"
  location = "northeurope"
}

resource "azurerm_resource_group" "devtest" {
  name     = "resourceguard-devtest-sample-rg"
  location = "northeurope"
  provider = azurerm.devtest
}

resource "azurerm_resource_group" "prd" {
  name     = "resourceguard-prd-sample-rg"
  location = "northeurope"
  provider = azurerm.prd
}

module "devtest-rsv" {
  source              = "../../recovery-services-vault"
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

module "prd-rsv" {
  source              = "../../recovery-services-vault"
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

module "prd-rguard" {
  source              = "../"
  resource_group_name = azurerm_resource_group.default.name
  location            = azurerm_resource_group.default.location

  name                 = "prd"
  disabled_protections = { get_security_pin = true }
  vault_ids            = { devtest-rsv = module.devtest-rsv.rsv_id, prd-rsv = module.prd-rsv.rsv_id }
}
