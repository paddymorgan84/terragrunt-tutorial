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

terraform {
  # Ensures paralellism never exceed two modules at any time
  extra_arguments "reduced_parallelism" {
    commands  = get_terraform_commands_that_need_parallelism()
    arguments = ["-parallelism=2"]
  }

  extra_arguments "common_tfvars" {
    commands = get_terraform_commands_that_need_vars()

    required_var_files = [
      "${get_parent_terragrunt_dir()}/tfvars/common.tfvars"
    ]
  }

  before_hook "before_hook" {
    commands     = ["apply"]
    execute      = ["echo", "Applying my terraform"]
  }

  after_hook "after_hook" {
    commands     = ["apply"]
    execute      = ["echo", "Finished applying Terraform successfully!"]
    run_on_error = false
  }
}
