# Packer Sensitive Variables and Secrets Management

## **1. Introduction to Handling Sensitive Variables in Packer**
Sensitive values like **API keys, passwords, and SSH keys** should never be hardcoded in Packer templates. Instead, Packer provides **secure handling mechanisms** to protect confidential data.

### **Key Considerations for Sensitive Variables:**
- **Marking variables as sensitive** to prevent logging.
- **Using environment variables** instead of hardcoding credentials.
- **Integrating with secret management tools** like HashiCorp Vault, AWS Secrets Manager, or Azure Key Vault.

---

## **2. Marking Variables as Sensitive in HCL**
Packer allows marking variables as `sensitive` to prevent them from appearing in logs.

### **Example: Defining a Sensitive Variable**
```hcl
variable "aws_access_key" {
  type        = string
  sensitive   = true
  description = "AWS Access Key for authentication."
}

variable "aws_secret_key" {
  type        = string
  sensitive   = true
  description = "AWS Secret Key for authentication."
}
```
Using these variables in a configuration:
```hcl
source "amazon-ebs" "aws_instance" {
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
}
```

### **Why Mark Variables as Sensitive?**
- Prevents values from being **printed in logs or CLI output**.
- Adds security when sharing logs with teams or CI/CD systems.

---

## **3. Using Environment Variables for Secrets**
Environment variables are a secure way to pass secrets **without hardcoding them** in Packer files.

### **Defining Environment Variables**
```sh
export PACKER_VAR_aws_access_key="AKIA..."
export PACKER_VAR_aws_secret_key="s3cr3t"
```
Packer automatically picks up these variables in the build.

### **Referencing Environment Variables in Packer**
```hcl
source "amazon-ebs" "aws_instance" {
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
}
```
**Why use environment variables?**
- Avoids committing credentials in Git repositories.
- Provides a secure way to manage secrets in CI/CD environments.

---

## **4. Storing Secrets in Third-Party Vaults**
For better security, secrets should be **stored in external secret managers**.

### **Using HashiCorp Vault**
1. **Store a secret in Vault:**
   ```sh
   vault kv put secret/aws access_key=AKIA... secret_key=s3cr3t
   ```
2. **Retrieve secrets in Packer dynamically:**
   ```hcl
   data "vault_generic_secret" "aws" {
     path = "secret/aws"
   }
   
   source "amazon-ebs" "aws_instance" {
     access_key = data.vault_generic_secret.aws.data["access_key"]
     secret_key = data.vault_generic_secret.aws.data["secret_key"]
   }
   ```

### **Using AWS Secrets Manager**
1. **Store a secret:**
   ```sh
   aws secretsmanager create-secret --name aws/packer --secret-string '{"access_key":"AKIA...", "secret_key":"s3cr3t"}'
   ```
2. **Retrieve it dynamically in Packer:**
   ```hcl
   data "aws_secretsmanager_secret_version" "aws" {
     secret_id = "aws/packer"
   }

   source "amazon-ebs" "aws_instance" {
     access_key = jsondecode(data.aws_secretsmanager_secret_version.aws.secret_string)["access_key"]
     secret_key = jsondecode(data.aws_secretsmanager_secret_version.aws.secret_string)["secret_key"]
   }
   ```

### **Using Azure Key Vault**
1. **Store a secret:**
   ```sh
   az keyvault secret set --vault-name "MyVault" --name "aws-access-key" --value "AKIA..."
   ```
2. **Retrieve it dynamically in Packer:**
   ```hcl
   data "azurerm_key_vault_secret" "aws_access_key" {
     name         = "aws-access-key"
     key_vault_id = azurerm_key_vault.my_vault.id
   }

   source "azure-arm" "azure_image" {
     client_id     = data.azurerm_key_vault_secret.aws_access_key.value
   }
   ```

---

## **5. Best Practices for Managing Sensitive Variables**
| Best Practice | Benefit |
|--------------|---------|
| **Use `sensitive` flag in HCL** | Prevents secrets from being logged. |
| **Use environment variables** | Keeps credentials out of templates. |
| **Use external secret managers** | Centralized, secure secret storage. |
| **Restrict IAM permissions** | Limits access to secrets based on roles. |
| **Avoid storing secrets in version control** | Prevents accidental exposure of credentials. |

For more details, visit **[Packer Security Best Practices](https://developer.hashicorp.com/packer/docs/security)**.

