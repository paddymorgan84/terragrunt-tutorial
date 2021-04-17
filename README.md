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

## Parallelism

Another nice feature of Terragrunt is when you do run commands such as `run-all`, it will run as many of the modules that have `terragrunt.hcl` files as possible in parallel. Terragrunt doesn't actually put a constraint on this, which is a blessing and a curse. Your infrastructure deployment times will be faster, but if you're not careful you can get rate limited by your provider, so use it with caution.

If you do start to experience rate limits, you can specify the `--terragrunt-parallelism` flag:

```bash
terragrunt run-all apply --terragrunt-parallelism 1
```

## DRY CLI Flags

It's quite likely that when you run terrafom you're running commands with extra arguments. For example, you may have some common variables that you pass for each module, or you may want to restrict parallelism to avoid rate limiting.

With Terragrunt, you can specify an `extra_arguments` block that makes sure that commands that you repeat each and every time are always included.
