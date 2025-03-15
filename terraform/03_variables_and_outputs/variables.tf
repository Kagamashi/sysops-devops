/* VARIABLE precedence (from highest to lowest_))
[1] variables passed using -var flag 
[2] variables files passed using -var-file flag
[3] terraform.tfvars or *.auto.tfvars files 
    These files are automatically loaded by Terraform
    These files are processed in lexical order of their filenames
[4] Environment variables: prefixed with TF_VAR_
[5] Default values in variable declarations */

variable "example" {
  type  = string  # string || number || bool || list(type) || map(type) || object
  default = "value"
  description = "Description of the variable"
  nullable = false  # defines whether the variable can accept null as a valid value.
  sensitive =  true # hides the value of the variable in logs
  validation {
    condition = can(regex("^[a-zA-Z0-9]*$", var.example))
    error_message = "The variable must contain only alphanumeric characters"
  }
  # validation {
  #   condition     = can(regex("^([0-9]{1,3}\\.){3}[0-9]{1,3}/[0-9]{1,2}$", var.vpc_cidr))
  #   error_message = "Validates CIDR format"
  # }
}


# LIST: a collection of values (similar to an array)
# each element can be accessed by its index: instance_type = var.instance_types[0]
variable "vm_sizes" {
  type    = list(string)
  default = ["Standard_B1s", "Standard_B2s"]  # List of Azure VM sizes
}


# MAP: collection of key-value pairs (similar to a dictionary)
# each element can be acess by its key: ami = var.amis["us-west-1"]
variable "vm_sizes" {
  type = map(string)
  default = {
    "eastus"    = "Standard_B1s"
    "westus"    = "Standard_B2s"
    "centralus" = "Standard_B2ms"
  }
}

# OBJECT: custom objects
# elements can be access like: var.server_config.cpu
variable "server_config" {
  type = object({
    cpu    = number
    memory = string
    disk   = number
  })
  default = {
    cpu    = 2
    memory = "4GB"
    disk   = 100
  }
}
