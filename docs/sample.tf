module "prd-rguard" {
  source              = "jsathler/resource-guard/azurerm"
  resource_group_name = azurerm_resource_group.default.name
  location            = azurerm_resource_group.default.location

  name                 = "prd"
  disabled_protections = { get_security_pin = true }
}
