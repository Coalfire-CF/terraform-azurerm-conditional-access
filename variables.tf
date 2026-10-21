variable "resource_prefix" {
  description = "A prefix that should be attached to the names of resources"
  type        = string
}

variable "state" {
  description = "Policy state. One of enabledForReportingButNotEnforced (default, report only), enabled or disabled. Setting enabled requires at least one excluded_users or excluded_groups entry for break-glass access."
  type        = string
  default     = "enabledForReportingButNotEnforced"

  validation {
    condition     = contains(["enabled", "disabled", "enabledForReportingButNotEnforced"], var.state)
    error_message = "state must be enabled, disabled or enabledForReportingButNotEnforced."
  }

  validation {
    condition     = var.state != "enabled" || length(var.excluded_users) + length(var.excluded_groups) > 0
    error_message = "state = \"enabled\" requires at least one break-glass user or group in excluded_users or excluded_groups. The policy targets all users."
  }
}

variable "excluded_users" {
  description = "Object IDs of users excluded from the policy, such as emergency access (break-glass) accounts."
  type        = list(string)
  default     = []
}

variable "excluded_groups" {
  description = "Object IDs of groups excluded from the policy, such as a group holding emergency access (break-glass) accounts."
  type        = list(string)
  default     = []
}

variable "authentication_strength_policy_id" {
  description = "Authentication strength the policy requires, in the form /policies/authenticationStrengthPolicies/<id>. Defaults to the built-in phishing-resistant MFA strength."
  type        = string
  default     = "/policies/authenticationStrengthPolicies/00000000-0000-0000-0000-000000000004"

  validation {
    condition     = can(regex("^/policies/authenticationStrengthPolicies/[0-9a-fA-F-]{36}$", var.authentication_strength_policy_id))
    error_message = "authentication_strength_policy_id must be /policies/authenticationStrengthPolicies/<GUID>."
  }
}
