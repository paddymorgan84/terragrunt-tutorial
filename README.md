# Terragrunt tutorial

This repo aims to give a tutorial around some of the features that Terragrunt offers, with examples for each.

## What is Terragrunt?

[Terragrunt](https://terragrunt.gruntwork.io/) is a thin wrapper that overlays [Terraform](https://www.terraform.io/) that allows you to avoid having large amounts of repetition in your infrastructure as code, as well as helping with terraform modules and remote state.

Terraform is a great tool, but it does lend itself towards some duplication which can get harder to manage the larger your solution becomes.

## DRY Backend

You can use your `terragrunt.hcl` files to reduce the duplication you have with terraform around your backend configuration. If you have a root `terragrunt.hcl` file, that can have the details around your backend configuration. Adding a child `terragrunt.hcl` file in each of the modules you want to run with the relevant configuration means that you can inherit the backend configuration outlined at the root.

## DRY Providers

You can use the [generate block](https://terragrunt.gruntwork.io/docs/reference/config-blocks-and-attributes#generate) in your root `terragrunt.hcl file` to inject common configuration files. One of the most common uses for it is to use it to generate your provider configuration. By adding the generate block in your root, you can delete the provider.tf files in your other directories. Whenever any terrafrunt command is called, the providers will be copied to the appropriate directories.

## Executing on multiple modules

When you use terraform, you can't run commands against all of your modules at the same time. With Terragrunt, you can. If you add a `terragrunt.hcl` file to each module, you can run commands using `run-all` from root to run every module. Terragrunt recursively looks through each of your directories for the presence of that file, and if it finds it, will run the command you've included with `run-all`.

For example, if you wanted to apply all of the modules in this solution, you can run the following commands from the root of your repo:

```bash
terragrunt run-all init
terragrunt run-all apply
```

If you subsequently wanted to tear down everything you had, you can run:

```bash
terragrunt run-all destroy
```
