# Terraform.d Directory and Configuration

The `~/.terraform.d` directory is typically located in the user's home directory and is used to store global settings, plugins, and configurations for Terraform.

---

## Contents of `~/.terraform.d`

### Plugins
- **Path:** `~/.terraform.d/plugins/`
- **Purpose:** Stores provider and provisioner binaries used globally across all Terraform configurations.

Example directory structure:
```
terraform.d/
├── plugins/
│   └── registry.terraform.io/
│       └── hashicorp/
│           └── aws/
│               └── 4.0.0/
│                   └── terraform-provider-aws_v4.0.0_x5
│   └── custom-provider/
│       └── 1.0.0/
│           └── terraform-provider-custom_v1.0.0
```

---

### CLI Configuration File: `.terraformrc`
- **Purpose:** Customizes the behavior of the Terraform CLI.
- **Common Settings:**
  - Proxy settings
  - Plugin directories
  - Provider credentials

Example `.terraformrc` file:
```hcl
credentials "app.terraform.io" {
  token = "your-terraform-cloud-token"
}

plugin_cache_dir = "$HOME/.terraform.d/plugin-cache"
```

---

### Credentials File: `credentials.tfrc.json`
- **Purpose:** Stores credentials for accessing private Terraform registries or Terraform Cloud.
- **Path:** `~/.terraform.d/credentials.tfrc.json`

Example `credentials.tfrc.json` file:
```json
{
  "credentials": {
    "app.terraform.io": {
      "token": "your-terraform-cloud-token"
    }
  }
}
```

---

### Plugin Cache: `plugin-cache`
- **Path:** `~/.terraform.d/plugin-cache/`
- **Purpose:** Caches provider binaries to avoid repeatedly downloading them during `terraform init`.

Example directory structure:
```
terraform.d/
├── plugin-cache/
│   └── registry.terraform.io/
│       └── hashicorp/
│           └── aws/
│               └── 4.0.0/
```

To enable the plugin cache, add the following to the `.terraformrc` file:
```hcl
plugin_cache_dir = "$HOME/.terraform.d/plugin-cache"
```

---

### Provider Installation Sources: `terraform-plugin-installation.json`
- **Purpose:** Defines alternative installation sources for Terraform providers.
- **Path:** `~/.terraform.d/terraform-plugin-installation.json`

Example `terraform-plugin-installation.json` file:
```json
{
  "provider_installation": {
    "hashicorp/aws": {
      "source": "registry.terraform.io/hashicorp/aws",
      "version": ">= 3.0.0"
    },
    "mycompany/custom-provider": {
      "source": "local/path/to/custom-provider",
      "version": ">= 1.0.0"
    }
  }
}
```
