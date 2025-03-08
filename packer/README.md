## Packer

**Packer** is an open-source tool by HashiCorp for **automating the creation of machine images** for multiple platforms, including **AWS AMIs, Azure VM images, GCP images, Docker containers, and VMware templates**.

- **Official Docs**: [https://developer.hashicorp.com/packer/docs](https://developer.hashicorp.com/packer/docs)
- **GitHub Repository**: [https://github.com/hashicorp/packer](https://github.com/hashicorp/packer)
- **Plugin Registry**: [https://developer.hashicorp.com/packer/plugins](https://developer.hashicorp.com/packer/plugins)
- **Provisioner Reference**: [https://developer.hashicorp.com/packer/docs/provisioners](https://developer.hashicorp.com/packer/docs/provisioners)
- **Template Examples**: [https://developer.hashicorp.com/packer/docs/templates](https://developer.hashicorp.com/packer/docs/templates)

---

### Dictionary (Key Packer Terms)

- **Template**: A JSON or HCL file defining how an image is built.
- **Builder**: Defines where the image will be built (e.g., AWS, Azure, GCP, VMware).
- **Provisioner**: Executes scripts or commands inside the image after it's created.
- **Post-Processor**: Executes tasks after an image is built (e.g., uploading to an artifact registry).
- **Variables**: Allow reusability in templates, such as region, instance type, etc.
- **Immutable Infrastructure**: A best practice where machine images are built once and never modified in production.

---
