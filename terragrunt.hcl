# Dynamically provision the remote state
remote_state {
  backend = "azurerm"

  config = {
    resource_group_name  = "BenSelbySandpit"
    storage_account_name = "paddystatestorage"
    container_name       = "tfstate"
    key                  = "${path_relative_to_include()}.tfstate"
  }
}
