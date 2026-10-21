variable "resource_prefix" {
  description = "Prefix for the conditional access policy name."
  type        = string
}

variable "break_glass_group_ids" {
  description = "Object IDs of groups that hold emergency access (break-glass) accounts. Excluded from the policy."
  type        = list(string)
}
