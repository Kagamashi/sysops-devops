# Service Principal
# non-human identities used for apps, automation, CI/CD, Terraform.. 

# Application is a Microsoft Entra ID object that is the global representation of a software application as defined by its developer. This object, created as part of application registration by the developer, determines the mechanism used by the application to issue tokens, the resources the application needs to access, and the actions that the application can take.
# Service principal is a Microsoft Entra ID object that is a local representation of a software application. This object gets created when the corresponding application is registered in the Entra tenant where the application will be used. The application object is used as a template to create the corresponding service principal object. The service principal object defines what the app is permitted to do in the local tenant, what resources the app can access, and who can access the app.

# service principal for an application
data "azuread_client_config" "current" {}

resource "azuread_application" "example" {
  display_name = "example"
  owners       = [data.azuread_client_config.current.object_id]
}

resource "azuread_service_principal" "example" {
  client_id                    = azuread_application.example.client_id
  app_role_assignment_required = false
  owners                       = [data.azuread_client_config.current.object_id]
}

# service principal for an enterprise application
data "azuread_client_config" "current" {}

resource "azuread_application" "example" {
  display_name = "example"
  owners       = [data.azuread_client_config.current.object_id]
}

resource "azuread_service_principal" "example" {
  client_id                    = azuread_application.example.client_id
  app_role_assignment_required = false
  owners                       = [data.azuread_client_config.current.object_id]

  feature_tags {
    enterprise = true
    gallery    = true
  }
}
