# Microsoft Defender for Cloud
# cloud-native security posture management CSPM and threat-protection solution that secures hybrid and multi-cloud environments
# provides continuous security assessment, threat protection, compliance monitoring for Azure/AWS/Google Cloud

#   - CSPM - identifies misconfigurations and security risks
#   - supports PCI DSS, ISO 27001, NIST, CIS Benchmarks
#   - Advanced Threat Protection (XDR - Extended Detection and Response)
#   - Zero Trust Security Model
#   - Multi Cloud supports - protects Azure, AWS, Google Cloud

# Defender for Cloud Security Plans:
#   - Defender for Servers:	Secures VMs & on-prem servers
#   - Defender for Storage:	Protects blob, file, and queue storage
#   - Defender for SQL:	Secures Azure SQL DB, VMs with SQL Server
#   - Defender for Kubernetes:	Monitors AKS, EKS, GKE clusters
#   - Defender for Containers:	Protects containerized applications
#   - Defender for App Services:	Secures Azure Web Apps & Functions
#   - Defender for Key Vault:	Detects unauthorized access & security threats
#   - Defender for DNS:	Identifies DNS-based attacks & exfiltration

# basic
resource "azurerm_security_center_subscription_pricing" "example" {
  tier          = "Standard"
  resource_type = "VirtualMachines" # https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/security_center_subscription_pricing#resource_type-1:~:text=and%20Standard.-,resource_type,-%2D%20(Optional)%20The%20resource
}

# using extensions with Defender CSPM
resource "azurerm_security_center_subscription_pricing" "example1" {
  tier          = "Standard"
  resource_type = "CloudPosture"

  extension {
    name = "ContainerRegistriesVulnerabilityAssessments"
  }

  extension {
    name = "AgentlessVmScanning"
    additional_extension_properties = {
      ExclusionTags = "[]"
    }
  }

  extension {
    name = "AgentlessDiscoveryForKubernetes"
  }

  extension {
    name = "SensitiveDataDiscovery"
  }
}

# alerts - requires Owner access
resource "azurerm_security_center_contact" "example" {
  name  = "contact"
  email = "contact@example.com"
  phone = "+1-555-555-5555"

  alert_notifications = true
  alerts_to_admins    = true
}
