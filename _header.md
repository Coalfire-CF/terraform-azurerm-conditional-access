![Coalfire](coalfire_logo.png)

# terraform-azurerm-conditional-access

## Description

This module creates one Entra ID conditional access policy. The policy applies to all users and all applications, but only to sign-ins where both the sign-in risk and the user risk are `medium`. It does not cover low-risk or high-risk sign-ins. When it applies, it requires an authentication strength (phishing-resistant MFA by default) and a 4-hour sign-in frequency. It starts in report-only mode.

It is used in the [Coalfire-Azure-RAMPpak](https://github.com/Coalfire-CF/Coalfire-Azure-RAMPpak) FedRAMP Framework.

Learn more at [Coalfire OpenSource](https://coalfire.com/opensource).

## Dependencies

- Microsoft Entra ID P1 for conditional access.
- Microsoft Entra ID P2 for the sign-in risk and user risk conditions.
- Microsoft Defender for Cloud Apps for `cloud_app_security_policy = "monitorOnly"`.
- The identity that runs Terraform needs the `Policy.ReadWrite.ConditionalAccess` and `Policy.Read.All` application roles, or the `Conditional Access Administrator` directory role.
- Users must register methods that meet the chosen authentication strength before you set `state = "enabled"`.

## Usage

```hcl
module "conditional_access" {
  source = "git::https://github.com/Coalfire-CF/terraform-azurerm-conditional-access?ref=v2.0.0"

  resource_prefix = "prod"
  excluded_groups = ["<break-glass group object ID>"]
}
```

See [examples/default](examples/default) for a complete root.

- The policy starts in report-only mode (`enabledForReportingButNotEnforced`).
- `state = "enabled"` needs at least one break-glass user or group in `excluded_users` or `excluded_groups`. The policy targets all users, so an enabled policy with no exclusion can lock out every administrator.
- Azure Government callers set `environment = "usgovernment"` on the azuread provider, or `usgovernmentl5` for DoD tenants.
