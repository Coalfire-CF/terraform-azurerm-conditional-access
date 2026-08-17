![Coalfire](coalfire_logo.png)

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

