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

# Generate an AWS provider block
generate "provider" {
  # Keep provider config in a dedicated file
  # excluded from git
  path      = "provider.tf"
  if_exists = "overwrite_terragrunt"
  contents  = <<EOF
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=2.46.0"
    }
  }
}
provider "azurerm" {
  features {}
  skip_provider_registration = true
}
EOF
}
