
## **Generating API Tokens for Automation or CI/CD**
API tokens in Cloudflare allow fine-grained access control for automation and CI/CD pipelines, including integration with **Azure DevOps**.

### **Steps to Generate an API Token**
1. **Log in to Cloudflare** and go to the [API Tokens section](https://dash.cloudflare.com/profile/api-tokens).
2. Click **Create Token**.
3. Select a **Template** or choose **Custom Token** to define granular permissions.
4. Configure permissions:
   - Example: For DNS automation, set **Zone** → **DNS Edit**.
5. Assign **specific zones** (domains) or select **All zones** for broader access.
6. Click **Continue to Summary**, review details, then click **Create Token**.
7. Copy and securely store the token, as it will not be shown again.

### **Using API Tokens in Azure DevOps Pipelines**
To integrate Cloudflare with Azure DevOps, store the API token securely in **Azure DevOps Service Connections or Azure Key Vault** and use it within pipelines.

- **Azure DevOps Pipeline Example:**
  ```yaml
  variables:
    CLOUDFLARE_API_TOKEN: $(CLOUDFLARE_API_TOKEN)
    ZONE_ID: $(ZONE_ID)
    RECORD_ID: $(RECORD_ID)

  jobs:
    - job: UpdateDNS
      displayName: "Update Cloudflare DNS"
      pool:
        vmImage: 'ubuntu-latest'
      steps:
        - script: |
            curl -X PUT "https://api.cloudflare.com/client/v4/zones/$ZONE_ID/dns_records/$RECORD_ID" \
                 -H "Authorization: Bearer $CLOUDFLARE_API_TOKEN" \
                 -H "Content-Type: application/json" \
                 --data '{"type":"A","name":"example.com","content":"192.168.1.1"}'
          displayName: "Update Cloudflare DNS Record"
  ```

- **Terraform with Azure DevOps:**
  ```hcl
  provider "cloudflare" {
    api_token = var.cloudflare_api_token
  }
  ```

Store `CLOUDFLARE_API_TOKEN` in **Azure DevOps variable groups** or **Azure Key Vault** for secure access.

---
