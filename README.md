<!-- BEGIN_TF_DOCS -->
# Azure Resource Guard Terraform module

Terraform module which creates Azure Resource Guard resources on Azure.

Supported Azure services:

* [Multi-user authorization using Resource Guard in Azure Backup](https://learn.microsoft.com/en-us/azure/backup/multi-user-authorization?tabs=azure-portal&pivots=vaults-recovery-services-vault)

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.5.6 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | >= 3.70.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | >= 3.70.0 |

## Resources

| Name | Type |
|------|------|
| [azurerm_data_protection_resource_guard.default](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/data_protection_resource_guard) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_disabled_protections"></a> [disabled\_protections](#input\_disabled\_protections) | An object containing the critical operations which are NOT protected by this Resource Guard. This parameter is optional<br>  - soft\_delete:      (optional) Disable 'soft delete or security features' protection. Defaults to 'false'<br>  - delete:           (optional) Disable 'Delete' protection. Defaults to 'false'<br>  - modify:           (optional) Disable 'Modify' protection. Defaults to 'false'<br>  - get\_security\_pin: (optional) Disable 'Get backup security PIN' protection. Defaults to 'false'<br>  - delete\_instance:  (optional) Disable 'Delete Backup Instance' protection. Defaults to 'false' | <pre>object({<br>    soft_delete      = optional(bool, false)<br>    delete           = optional(bool, false)<br>    modify           = optional(bool, false)<br>    get_security_pin = optional(bool, false)<br>    delete_instance  = optional(bool, false)<br>  })</pre> | `{}` | no |
| <a name="input_location"></a> [location](#input\_location) | The region where the VM will be created. This parameter is required | `string` | `"northeurope"` | no |
| <a name="input_name"></a> [name](#input\_name) | The name of the Resource Guard. This parameter is required | `string` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | The name of the resource group in which the resources will be created. This parameter is required | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags to be applied to resources. This parameter is optional | `map(string)` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_resource_guard_id"></a> [resource\_guard\_id](#output\_resource\_guard\_id) | Resource Guard ID |
| <a name="output_resource_guard_name"></a> [resource\_guard\_name](#output\_resource\_guard\_name) | Resource Guard name |

## Examples
```hcl
module "prd-rguard" {
  source              = "jsathler/resource-guard/azurerm"
  resource_group_name = azurerm_resource_group.default.name
  location            = azurerm_resource_group.default.location

  name                 = "prd"
  disabled_protections = { get_security_pin = true }
}
```
More examples in ./examples folder
<!-- END_TF_DOCS -->