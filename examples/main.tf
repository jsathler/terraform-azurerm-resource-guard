provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "default" {
  name     = "resourceguard-example-rg"
  location = "northeurope"
}

module "prd-rguard" {
  source              = "../"
  resource_group_name = azurerm_resource_group.default.name
  location            = azurerm_resource_group.default.location

  name                 = "prd"
  disabled_protections = { get_security_pin = true }
}
