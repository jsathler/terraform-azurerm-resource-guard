# Azure Resource Guard Terraform module

Terraform module which creates Azure Resource Guard resources on Azure.

These types of resources are supported:

* [Multi-user authorization using Resource Guard in Azure Backup](https://learn.microsoft.com/en-us/azure/backup/multi-user-authorization?tabs=azure-portal&pivots=vaults-recovery-services-vault)

## Terraform versions

Terraform 1.5.6 and newer.

## Usage

```hcl
module "prd-rguard" {
  source              = "jsathler/resource-guard/azurerm"
  resource_group_name = azurerm_resource_group.default.name
  location            = azurerm_resource_group.default.location

  name                 = "prd"
  disabled_protections = { get_security_pin = true }
  vault_ids            = { devtest-rsv = module.devtest-rsv.rsv_id, prd-rsv = module.prd-rsv.rsv_id }
}
```

More samples in examples folder