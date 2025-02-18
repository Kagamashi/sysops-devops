
terraform {
  required_providers {
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "~> 4.0"
    }
  }
}

variable cloudflare_api_token {}

provider "cloudflare" {
  api_token = var.cloudflare_api_token
}
