variable "storage_account_name" {
  default     = "notanotherstorageaccount"
  description = "The storage account name"
}

variable "resource_group_name" {
  default     = "BenSelbySandpit"
  description = "The name of the resource group to deploy the resources to"
}

variable "resource_group_location" {
  default     = "West Europe"
  description = "Where are the resources deployed"
}
