# Infrastructure as Code (IaC)

## 1. Overview
Infrastructure as Code (IaC) allows for **automated, repeatable, and version-controlled** infrastructure management. In Google Cloud, IaC is primarily implemented using **Deployment Manager, Terraform, and configuration management tools like Ansible, Puppet, or Chef**.

---

## 2. Deployment Manager Templates
Deployment Manager is a **native GCP IaC tool** that allows defining resources in **YAML or Python templates**.

### **Example: Creating a Simple Deployment**
```yaml
resources:
- name: my-vm
  type: compute.v1.instance
  properties:
    zone: us-central1-a
    machineType: zones/us-central1-a/machineTypes/n1-standard-1
    disks:
    - boot: true
      autoDelete: true
      initializeParams:
        sourceImage: projects/debian-cloud/global/images/family/debian-11
```

### **Deploying a Configuration**
```sh
gcloud deployment-manager deployments create my-deployment --config=config.yaml
```

### **Deleting a Deployment**
```sh
gcloud deployment-manager deployments delete my-deployment
```

---

## 3. Terraform on GCP
Terraform is an **open-source, declarative IaC tool** widely used for managing GCP infrastructure.

### **1. Using the GCP Provider in Terraform**
```hcl
provider "google" {
  project = "my-project"
  region  = "us-central1"
}
```

### **2. Structuring Terraform Environments**
- **State management**: Store Terraform state in Google Cloud Storage.
- **Modules**: Use reusable modules for consistent infrastructure provisioning.
- **Workspaces**: Manage different environments (dev/staging/prod) efficiently.

```sh
terraform init
terraform plan
terraform apply
```

### **3. Storing Terraform State in GCS**
```hcl
terraform {
  backend "gcs" {
    bucket  = "my-terraform-state"
    prefix  = "terraform/state"
  }
}
```

---

## 4. Configuration Management (Ansible, Puppet, Chef)
Configuration management tools ensure **system consistency, automated provisioning, and compliance**.

### **1. Ansible on GCP**
- Uses **GCP modules** for provisioning.
- Automates **package installations, security configurations, and updates**.

```yaml
- name: Deploy VM on GCP
  hosts: localhost
  tasks:
    - name: Create a GCP VM
      gcp_compute_instance:
        name: my-instance
        machine_type: n1-standard-1
        zone: us-central1-a
        project: my-project
```

### **2. Puppet on GCP**
- Automates **OS configurations and software management**.
- Can be integrated with **GCP VMs** via startup scripts.

### **3. Chef on GCP**
- Uses **Cookbooks** to define system configurations.
- Can be **integrated into GCP workflows** via Cloud Build and Compute Engine.

---

## 5. Final Checklist
✅ Use **Deployment Manager for native GCP deployments**.  
✅ Implement **Terraform for scalable, cloud-agnostic infrastructure**.  
✅ Store Terraform state in **Google Cloud Storage for reliability**.  
✅ Automate OS and configuration management with **Ansible, Puppet, or Chef**.  
✅ Enforce **IaC best practices (version control, modularization, and state management)**.  

📌 **More Resources:** [Terraform GCP Documentation](https://registry.terraform.io/providers/hashicorp/google/latest/docs) | [GCP Deployment Manager Docs](https://cloud.google.com/deployment-manager/docs/)

