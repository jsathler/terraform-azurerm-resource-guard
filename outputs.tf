output "resource_guard_name" {
  description = "Resource Guard name"
  value       = azurerm_data_protection_resource_guard.default.name
}

output "resource_guard_id" {
  description = "Resource Guard ID"
  value       = azurerm_data_protection_resource_guard.default.id
}
