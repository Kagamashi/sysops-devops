
## **Provisioner Overview**
Packer **provisioners** allow scripts, configurations, or files to be executed inside the built image.

### **Built-in Provisioners:**
| Provisioner | Purpose |
|-------------|---------|
| `shell` | Runs shell scripts to install packages or configure the system. |
| `file` | Uploads files or directories to the image. |
| `ansible` | Uses Ansible playbooks for provisioning. |
| `chef` | Installs and runs Chef recipes. |
| `puppet` | Runs Puppet manifests for system configuration. |

### **Example: Using a Shell Provisioner**
```hcl
provisioner "shell" {
  inline = [
    "sudo apt-get update",
    "sudo apt-get install -y nginx"
  ]
}
```
This installs **NGINX** inside the VM image.

### **Example: Uploading a File**
```hcl
provisioner "file" {
  source      = "./config/nginx.conf"
  destination = "/etc/nginx/nginx.conf"
}
```
This copies the `nginx.conf` file to the VM.

### **Example: Running an Ansible Playbook**
```hcl
provisioner "ansible" {
  playbook_file = "playbook.yml"
}
```
This applies an **Ansible playbook** to configure the system.

---
