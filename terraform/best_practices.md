# Terraform Best Practices

## Code Structure

### 1. Directory Structure
Organize your Terraform configurations for clarity and scalability:
```
root/
├── modules/
│   ├── network/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   └── outputs.tf
│   └── compute/
│       ├── main.tf
│       ├── variables.tf
│       └── outputs.tf
├── dev/
│   └── main.tf
│   └── variables.tf
│   └── terraform.tfvars
└── prod/
    └── main.tf
    └── variables.tf
    └── terraform.tfvars
```

### 2. Logical Separation
Separate concerns like networking, compute resources, and storage into different modules and files:
- **Example:**
  - `network.tf`:
    ```hcl
    resource "aws_vpc" "main" {
      cidr_block = var.vpc_cidr
    }
    ```
  - `compute.tf`:
    ```hcl
    resource "aws_instance" "web" {
      ami           = "ami-0c55b159cbfafe1f0"
      instance_type = "t2.micro"
      subnet_id     = aws_subnet.public.id
    }
    ```

### 3. Naming Conventions
Use clear and consistent names for resources and variables. Adjust according to organizational policies.

---

## Reusable Code

### 1. Modules
Encapsulate reusable configurations into modules for better reusability and maintainability.

### 2. Parametrize Configuration
Avoid hardcoding values; use variables instead to allow customization:
- Define in `variables.tf`.
- Assign in `terraform.tfvars`.

### 3. Outputs
Use `outputs.tf` to expose key information, making it accessible to other modules or users:
```hcl
output "vpc_id" {
  value = aws_vpc.main.id
}
```

### 4. Formatting and Validation
Run `terraform fmt` and `terraform validate` to ensure your code is clean and error-free.

---

## Variables

### 1. Use `.tfvars` Files
Store environment-specific values in `.tfvars` files (e.g., `terraform.tfvars` for default values):
```hcl
vpc_cidr = "10.0.0.0/16"
instance_type = "t2.micro"
```

### 2. Variable Precedence
Remember the order of variable precedence:
1. Command-line flags.
2. Environment variables.
3. `.tfvars` files.
4. Default values in `variables.tf`.

---

## Security

### 1. Secrets Management
- Avoid hardcoding secrets in code.
- Use tools like HashiCorp Vault or AWS Secrets Manager to securely store secrets.

### 2. Sensitive Variables
Mark variables as sensitive to prevent Terraform from displaying them in CLI outputs:
```hcl
variable "db_password" {
  type      = string
  sensitive = true
}
```

### 3. Secure State Files
Use secure backends (e.g., S3 with encryption) to store Terraform state files:
```hcl
terraform {
  backend "s3" {
    bucket         = "my-terraform-state"
    key            = "prod/terraform.tfstate"
    region         = "us-west-2"
    encrypt        = true
    dynamodb_table = "terraform-lock"
  }
}
```
