# Azure Logic App
# severless workflow automation service enabling integreation of cloud services, on-premises systems and APIs using low-code/no-code automation

# Event-driven Automation - triggers based on HTTP calls, schedule, API events, file uploads, message queues
# Connectors & Integration - 400+ built-in connectors for Azure, AWS, GCP, databases, APIs, SaaS apps
#    - built-in: Azure Services
#    - SaaS connectors: Salesforce, Office365, Google Drive, Twilio, ServiceNow
#    - custom connectors: own APIs, GraphQL, SOAP services
# Hybrid & On-prem integration
# Serverless & Cost efficient - pay only for execution time, no infrastructure mgmt

resource "azurerm_logic_app_workflow" "example" {
  name                = "workflow1"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
}

# scheduled execution based on HTTP trigger
resource "azurerm_logic_app_trigger_http_request" "example" {
  name         = "http-trigger"
  logic_app_id = azurerm_logic_app_workflow.example.id
  schema       = <<EOF
  {
    "type": "object",
    "properties": {
      "filename": {
        "type": "string"
      }
    }
  }
  EOF
}

# action - send email via Office365
resource "azurerm_logic_app_action_http" "example" {
  name         = "send-email"
  logic_app_id = azurerm_logic_app_workflow.example.id
  method       = "POST"
  uri          = "https://graph.microsoft.com/v1.0/me/sendMail"

  headers = {
    "Content-Type"  = "application/json"
    "Authorization" = "Bearer <access_token>" # Replace with OAuth token
  }

  body = jsonencode({
    message = {
      subject = "Logic App Alert"
      body = {
        contentType = "Text"
        content     = "New file uploaded to storage."
      }
      toRecipients = [
        { emailAddress = { address = "user@example.com" } }
      ]
    }
  })
}
