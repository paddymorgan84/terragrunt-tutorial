terraform {
  backend "azurerm" {
    resource_group_name  = "BenSelbySandpit"
    storage_account_name = "paddystatestorage"
    container_name       = "tfstate"
    key                  = "storage.tfstate"
  }
}
