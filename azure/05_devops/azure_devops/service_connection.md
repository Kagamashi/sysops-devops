# Service Connections in Azure DevOps

## **What is a Service Connection?**
A **Service Connection** in Azure DevOps (ADO) is a secure way to connect Azure DevOps Pipelines to external services like Azure, AWS, Docker, GitHub, and others without hardcoding credentials. Service connections allow pipelines to authenticate and interact with these services while keeping credentials secure.

## **Why Use Service Connections?**
- **Security:** Credentials are stored securely and not exposed in pipeline scripts.
- **Automation:** Enables automated deployments, integrations, and infrastructure provisioning.
- **Centralized Management:** Service connections are centrally managed in Azure DevOps and can be reused across pipelines.
- **Access Control:** Permissions can be controlled via Role-Based Access Control (RBAC).

## **Types of Service Connections**
1. **Azure Service Connection:**
   - Uses **Service Principal** or **Managed Identity** to authenticate with Azure.
   - Grants access to Azure resources like Virtual Machines, App Services, Key Vault, etc.
   
2. **AWS Service Connection:**
   - Uses AWS access keys to interact with AWS services.

3. **Docker Service Connection:**
   - Connects to Docker Hub or Azure Container Registry (ACR) for container image storage and deployments.

4. **GitHub Service Connection:**
   - Integrates with GitHub for repository access, pull requests, and GitHub Actions workflows.

## **Creating a Service Connection in Azure DevOps**
1. **Navigate to Azure DevOps Project** → **Project Settings** → **Service Connections**.
2. Click **New service connection**.
3. Choose the service type (Azure, AWS, Docker, etc.).
4. Configure authentication details:
   - For **Azure**, select **Service Principal** or **Managed Identity**.
   - For **AWS**, provide Access Key ID and Secret Access Key.
5. Name the connection and set permissions.
6. Click **Save**.

## **Using a Service Connection in a YAML Pipeline**
Once created, a service connection can be referenced in YAML pipelines.

### **Example: Deploying an Azure Web App using Azure Service Connection**
```yaml
# Deploys a web application to Azure using a service connection
trigger:
  - main

pool:
  vmImage: 'ubuntu-latest'

steps:
  - task: AzureCLI@2
    inputs:
      azureSubscription: 'MyAzureServiceConnection' # Refers to the service connection
      scriptType: 'bash'
      scriptLocation: 'inlineScript'
      inlineScript: |
        az webapp deployment source config-zip \
          --resource-group myResourceGroup \
          --name myApp \
          --src myapp.zip
```

### **Example: Deploying a Docker Image using a Docker Service Connection**
```yaml
# Pushes a Docker image to Azure Container Registry using a service connection
trigger:
  - main

pool:
  vmImage: 'ubuntu-latest'

steps:
  - task: Docker@2
    inputs:
      containerRegistry: 'MyDockerServiceConnection' # Docker service connection
      repository: 'myrepository/myimage'
      command: 'buildAndPush'
      Dockerfile: '**/Dockerfile'
```

### **Example: Cloning a Private GitHub Repo using a GitHub Service Connection**
```yaml
# Checks out code from a private GitHub repository using a service connection
resources:
  repositories:
    - repository: myGitHubRepo
      type: github
      endpoint: 'MyGitHubServiceConnection' # GitHub service connection
      name: myorganization/myrepository

steps:
  - checkout: myGitHubRepo
```

## **Best Practices for Service Connections**
- **Use Managed Identity** where possible to reduce credential exposure.
- **Limit permissions** to only what the pipeline needs (Principle of Least Privilege).
- **Rotate credentials** for service connections periodically.
- **Restrict who can use or edit service connections** in Azure DevOps settings.
- **Use different service connections for different environments** (Dev, Test, Prod).

## **Conclusion**
Service connections in Azure DevOps are essential for secure, scalable, and automated CI/CD workflows. They enable pipelines to interact with external services without compromising security, making deployments efficient and manageable.