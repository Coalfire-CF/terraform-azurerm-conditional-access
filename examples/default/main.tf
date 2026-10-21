terraform {
  required_version = ">= 1.16.6, < 2.0"

  required_providers {
    azuread = {
      source  = "hashicorp/azuread"
      version = "~> 3.10"
    }
  }
}

provider "azuread" {
  environment = "usgovernment"
}

module "conditional_access" {
  source = "../.."

  resource_prefix = var.resource_prefix
  state           = "enabledForReportingButNotEnforced"
  excluded_groups = var.break_glass_group_ids
}
