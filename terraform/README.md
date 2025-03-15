## Terraform

**Terraform** is an open-source **Infrastructure as Code (IaC)** tool by HashiCorp, enabling you to manage and provision infrastructure across various clouds and services in a **declarative** and **version-controlled** manner.

- **Official Docs**: [https://developer.hashicorp.com/terraform/docs](https://developer.hashicorp.com/terraform/docs)
- **GitHub Repository**: [https://github.com/hashicorp/terraform](https://github.com/hashicorp/terraform)
- **Registry (Providers, Modules)**: [https://registry.terraform.io/](https://registry.terraform.io/)
- **Tutorials and Examples**: [https://developer.hashicorp.com/terraform/tutorials](https://developer.hashicorp.com/terraform/tutorials)

---

### Dictionary

- **Provider**: A plugin that allows Terraform to interact with APIs of cloud platforms and other services (e.g., AWS, GCP, Kubernetes).
- **Module**: A reusable package of Terraform configurations, abstracting resource definitions.
- **State**: A JSON file (`terraform.tfstate`) that records the real-time mapping of your resources to Terraform configurations.
- **Plan**: A preview of changes Terraform will perform to reach the desired state (`terraform plan`).
- **Apply**: The action to create, update, or destroy resources to match your configuration (`terraform apply`).
- **Destroy**: The action to remove all resources managed by your Terraform configuration (`terraform destroy`).
- **Workspace**: A feature to maintain multiple state files within the same configuration (e.g., dev, prod).
- **Provisioner**: Executes scripts or commands on a local or remote machine during resource creation.

---

### CRDs (Custom Resource Definitions)

Terraform **does not** natively use CRDs in Kubernetes.  
However, there are **Terraform Operators** for Kubernetes that introduce their own CRDs to manage Terraform runs within a cluster (e.g., [Rancher’s Fleet, Terraform Controller, etc.](https://github.com/isaaguilar/terraform-operator)).

---
