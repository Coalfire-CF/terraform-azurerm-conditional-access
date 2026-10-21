# Entra ID conditional access policy
resource "azuread_conditional_access_policy" "default" {
  display_name = "${var.resource_prefix}-conditional_access-ply"
  state        = var.state

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
      included_users  = ["All"]
      excluded_users  = var.excluded_users
      excluded_groups = var.excluded_groups
    }
  }

  grant_controls {
    operator                          = "AND"
    authentication_strength_policy_id = var.authentication_strength_policy_id
  }

  session_controls {
    application_enforced_restrictions_enabled = true
    cloud_app_security_policy                 = "monitorOnly"
    sign_in_frequency_period                  = "hours"
    sign_in_frequency                         = 4
    persistent_browser_mode                   = "never"
  }
}
