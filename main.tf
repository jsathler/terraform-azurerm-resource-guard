locals {
  tags = merge(var.tags, { ManagedByTerraform = "True" })
  critical_operations = compact([
    var.disabled_protections.soft_delete ? "Microsoft.RecoveryServices/vaults/backupPolicies/write" : "",
    var.disabled_protections.delete ? "Microsoft.RecoveryServices/vaults/backupFabrics/protectionContainers/protectedItems/delete" : "",
    var.disabled_protections.modify ? "Microsoft.RecoveryServices/vaults/backupFabrics/protectionContainers/protectedItems/write" : "",
    var.disabled_protections.get_security_pin ? "Microsoft.RecoveryServices/vaults/backupSecurityPIN/action" : "",
    var.disabled_protections.delete_instance ? "Microsoft.DataProtection/backupVaults/backupInstances/delete" : ""
  ])
}

resource "azurerm_data_protection_resource_guard" "default" {
  name                                    = "${var.name}-rguard"
  resource_group_name                     = var.resource_group_name
  location                                = var.location
  vault_critical_operation_exclusion_list = local.critical_operations
}
