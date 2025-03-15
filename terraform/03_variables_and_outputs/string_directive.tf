# If you don't specify a type for a variable, Terraform accepts any type (string, number, list, etc.).

# Terraform supports multi-line strings using <<EOF or a similar delimiter.
variable "multi_line_example" {
  default = <<EOT
  This is a multi-line
  string in Terraform.
  EOT
}


# Terraform includes several string manipulation functions like upper(), lower(), join(), split(), etc.
variable "resource_suffix" {
  default = "Prod"
}

output "upper_suffix" {
  value = upper(var.resource_suffix)  # Converts "Prod" to "PROD"
}


# You can validate string inputs using the validation block.
variable "environment" {
  type    = string
  default = "dev"

  validation {
    condition     = contains(["dev", "test", "prod"], var.environment)
    error_message = "The environment must be one of: dev, test, prod."
  }
}
