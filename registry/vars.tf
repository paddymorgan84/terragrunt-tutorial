variable "registry_name" {
  default     = "paddysregistry"
  description = "The container registry name"
}

variable "resource_group_name" {
  default     = "BenSelbySandpit"
  description = "The name of the resource group to deploy the resources to"
}

variable "resource_group_location" {
  default     = "West Europe"
  description = "Where are the resources deployed"
}
