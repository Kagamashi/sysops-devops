# Multi-Factor Authentication [MFA]
# security feature in Microsoft Entra ID that adds an extra layer of protection by requiring users to verify their identity using multiple authentication methods

#   - protects against password-based attacks
#   - supports OTP, phone call, push notifications, hardware tokens
#   - use Conditional Access Policies
#   - integration with 3rd party apps - OAuth, SAML-based apps

# MFA Authentication Methods:
#   - Microsoft Authenticator App (most secure)
#   - Phone Call
#   - SMS OTP
#   - FIDO2 Security Keys
#   - Windows Hello for Business (biometric)

# Per-User MFA (basic): users must complete MFA every time they log in
# Conditional Access MFA (recommended): applies MFA only when needed based on risk factors: location, device compliance, user role, sign-in risk level

resource "azuread_conditional_access_policy" "example" {
  display_name = "example policy"
  state        = "disabled"

  conditions {
    client_app_types    = ["all"]
    sign_in_risk_levels = ["medium"]
    user_risk_levels    = ["medium"]

    applications {
      included_applications = ["All"]
      excluded_applications = []
    }

    devices {
      filter {
        mode = "exclude"
        rule = "device.operatingSystem eq \"Doors\""
      }
    }

    locations {
      included_locations = ["All"]
      excluded_locations = ["AllTrusted"]
    }

    platforms {
      included_platforms = ["android"]
      excluded_platforms = ["iOS"]
    }

    users {
      included_users = ["All"]
      excluded_users = ["GuestsOrExternalUsers"]
    }
  }

  grant_controls {
    operator          = "OR"
    built_in_controls = ["mfa"]
  }

  session_controls {
    application_enforced_restrictions_enabled = true
    disable_resilience_defaults               = false
    sign_in_frequency                         = 10
    sign_in_frequency_period                  = "hours"
    cloud_app_security_policy                 = "monitorOnly"
  }
}

# check MFA registration status
# az ad user list --query "[].{User:displayName, MFA:strongAuthenticationDetail}" --output table

# check conditional access MFA reports
# az ad conditional-access policy list --query "[].{Name:displayName, State:state}" --output table

# force MFA for a specific user
# az ad user update --id user@example.com --force-change-password-next-sign-in
