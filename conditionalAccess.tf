# AAD Conditional Access Policy
resource "azuread_conditional_access_policy" "default" {
  display_name = "${var.resource_prefix}-conditional_access-ply"
  state        = "enabledForReportingButNotEnforced" #change to enabled when ready

  conditions {
    client_app_types    = ["browser", "mobileAppsAndDesktopClients"]
    sign_in_risk_levels = ["medium"]
    user_risk_levels    = ["medium"]

    applications {
      included_applications = ["All"]
    }

    locations {
      included_locations = ["All"]
    }

    platforms {
      included_platforms = ["all"]
    }

    users {
      included_users = ["All"]
    }
  }

  grant_controls {
    operator                          = "AND"
    built_in_controls                 = ["mfa"]
    authentication_strength_policy_id = "00000000-0000-0000-0000-000000000004"
  }

  session_controls {
    application_enforced_restrictions_enabled = true
    cloud_app_security_policy                 = "monitorOnly"
    sign_in_frequency_period                  = "hours"
    sign_in_frequency                         = 4
    persistent_browser_mode                   = "never"
  }
}
