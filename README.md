# Terragrunt tutorial

This repo aims to give a tutorial around some of the features that Terragrunt offers, with examples for each.

## What is Terragrunt?

[Terragrunt](https://terragrunt.gruntwork.io/) is a thin wrapper that overlays [Terraform](https://www.terraform.io/) that allows you to avoid having large amounts of repetition in your infrastructure as code, as well as helping with terraform modules and remote state.

Terraform is a great tool, but it does lend itself towards some duplication which can get harder to manage the larger your solution becomes.

## DRY Backend

You can use your `terragrunt.hcl` files to reduce the duplication you have with terraform around your backend configuration. If you have a root `terragrunt.hcl` file, that can have the details around your backend configuration. Adding a child `terragrunt.hcl` file in each of the modules you want to run with the relevant configuration means that you can inherit the backend configuration outlined at the root.
