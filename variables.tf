variable "location" {
  description = "The region where the VM will be created. This parameter is required"
  type        = string
  default     = "northeurope"
}

variable "resource_group_name" {
  description = "The name of the resource group in which the resources will be created. This parameter is required"
  type        = string
}

variable "tags" {
  description = "Tags to be applied to resources. This parameter is optional"
  type        = map(string)
  default     = null
}

variable "name" {
  description = "The name of the Resource Guard. This parameter is required"
  type        = string
}

variable "disabled_protections" {
  description = <<DESCRIPTION
  An object containing the critical operations which are NOT protected by this Resource Guard. This parameter is optional
  - soft_delete:      (optional) Disable 'soft delete or security features' protection. Defaults to 'false'
  - delete:           (optional) Disable 'Delete' protection. Defaults to 'false'
  - modify:           (optional) Disable 'Modify' protection. Defaults to 'false'
  - get_security_pin: (optional) Disable 'Get backup security PIN' protection. Defaults to 'false'
  - delete_instance:  (optional) Disable 'Delete Backup Instance' protection. Defaults to 'false'

  DESCRIPTION

  type = object({
    soft_delete      = optional(bool, false)
    delete           = optional(bool, false)
    modify           = optional(bool, false)
    get_security_pin = optional(bool, false)
    delete_instance  = optional(bool, false)
  })
  default = {}
}
