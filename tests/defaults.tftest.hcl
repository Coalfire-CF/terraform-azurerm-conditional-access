mock_provider "azuread" {}

variables {
  resource_prefix = "test"
}

run "secure_defaults" {
  command = plan

  assert {
    condition     = azuread_conditional_access_policy.default.state == "enabledForReportingButNotEnforced"
    error_message = "The policy must default to report-only."
  }

  assert {
    condition     = azuread_conditional_access_policy.default.grant_controls[0].authentication_strength_policy_id == "/policies/authenticationStrengthPolicies/00000000-0000-0000-0000-000000000004"
    error_message = "The policy must require the phishing-resistant MFA strength by default."
  }

  assert {
    condition     = azuread_conditional_access_policy.default.grant_controls[0].built_in_controls == null
    error_message = "built_in_controls must not set mfa alongside an authentication strength."
  }

  assert {
    condition     = azuread_conditional_access_policy.default.session_controls[0].persistent_browser_mode == "never"
    error_message = "Persistent browser sessions must be disabled."
  }

  assert {
    condition     = azuread_conditional_access_policy.default.session_controls[0].sign_in_frequency == 4 && azuread_conditional_access_policy.default.session_controls[0].sign_in_frequency_period == "hours"
    error_message = "Sign-in frequency must be 4 hours."
  }

  assert {
    condition     = azuread_conditional_access_policy.default.conditions[0].users[0].included_users == tolist(["All"])
    error_message = "The policy must target all users."
  }
}

run "enabled_with_break_glass" {
  command = plan

  variables {
    state          = "enabled"
    excluded_users = ["11111111-1111-1111-1111-111111111111"]
  }

  assert {
    condition     = azuread_conditional_access_policy.default.state == "enabled"
    error_message = "state = enabled with a break-glass exclusion must be accepted."
  }

  assert {
    condition     = azuread_conditional_access_policy.default.conditions[0].users[0].excluded_users == tolist(["11111111-1111-1111-1111-111111111111"])
    error_message = "excluded_users must reach the policy."
  }
}

run "enabled_without_break_glass_fails" {
  command = plan

  variables {
    state = "enabled"
  }

  expect_failures = [var.state]
}

run "bare_guid_strength_fails" {
  command = plan

  variables {
    authentication_strength_policy_id = "00000000-0000-0000-0000-000000000004"
  }

  expect_failures = [var.authentication_strength_policy_id]
}

run "invalid_state_fails" {
  command = plan

  variables {
    state = "on"
  }

  expect_failures = [var.state]
}

run "custom_strength_accepted" {
  command = plan

  variables {
    authentication_strength_policy_id = "/policies/authenticationStrengthPolicies/a1b2c3d4-0000-4000-8000-123456789abc"
  }

  assert {
    condition     = azuread_conditional_access_policy.default.grant_controls[0].authentication_strength_policy_id == "/policies/authenticationStrengthPolicies/a1b2c3d4-0000-4000-8000-123456789abc"
    error_message = "A custom authentication strength ID must be accepted and reach the policy."
  }
}
