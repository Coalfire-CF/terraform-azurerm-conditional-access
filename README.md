<div align="center">
<img src="coalfire_logo.png" width="200">

</div>

# terraform-azurerm-conditional-access

## Description

This module has the terraform to setup MFA and related access controls for FedRAMP Moderate. It is used in the [Coalfire-Azure-RAMPpak](https://github.com/Coalfire-CF/Coalfire-Azure-RAMPpak) FedRAMP Framework. 

Learn more at [Coalfire OpenSource](https://coalfire.com/opensource).

## Dependencies

- Before this module is used, a valid P1/P2 license needs to be assigned to the users in the environment.

## Deployment Steps

This module can be called as outlined below.

- Change directories to the `reponame` directory.
- From the `terraform/azure/reponame` directory run `terraform init`.
- Run `terraform plan` to review the resources being created.
- If everything looks correct in the plan output, run `terraform apply`.

#### Code Location

Code should be stored in terraform/mgmt/conditionalAccess

<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azuread"></a> [azuread](#provider\_azuread) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azuread_conditional_access_policy.default](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/conditional_access_policy) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_resource_prefix"></a> [resource\_prefix](#input\_resource\_prefix) | A prefix that should be attached to the names of resources | `string` | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->
## Contributing

[Start Here](CONTRIBUTING.md)

## License

[![License](https://img.shields.io/badge/license-MIT-blue.svg)](https://opensource.org/license/mit/)

## Contact Us

[Coalfire](https://coalfire.com/)

### Copyright

Copyright © 2023 Coalfire Systems Inc.