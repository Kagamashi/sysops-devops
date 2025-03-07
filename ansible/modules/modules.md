
## Core Modules Overview

Ansible **modules** are the building blocks of automation. They execute tasks such as file manipulation, package installation, and service management.

### **Commonly Used Modules**
| Module | Purpose |
|--------|---------|
| `file` | Create, delete, or modify files and directories |
| `copy` | Copy files from local to remote systems |
| `template` | Deploy Jinja2 templates with dynamic variables |
| `lineinfile` | Modify specific lines in a file |
| `replace` | Replace text in files |
| `service` | Manage system services (start, stop, restart) |
| `systemd` | Control `systemd` services |

### **Example: Using the `file` Module**
```yaml
- name: Create a directory
  file:
    path: /opt/myapp
    state: directory
    mode: '0755'
```

### **Example: Using the `copy` Module**
```yaml
- name: Copy a config file
  copy:
    src: local_config.cfg
    dest: /etc/myapp/config.cfg
    owner: root
    group: root
    mode: '0644'
```

---

## Package Management Modules

Ansible provides platform-specific package managers.

| Module | Package Manager |
|--------|----------------|
| `yum` | RHEL-based (CentOS, AlmaLinux, Rocky) |
| `dnf` | Newer RHEL-based systems |
| `apt` | Debian-based (Ubuntu, Debian) |
| `pip` | Python packages |
| `npm` | Node.js packages |
| `snap` | Ubuntu Snap packages |

### **Example: Install Nginx on Different OS**
```yaml
- name: Install Nginx
  package:
    name: nginx
    state: present
```
- The `package` module works across **all Linux distros** (auto-selects the correct manager).

---

## Networking and Cloud Modules

Ansible integrates with **cloud providers and networking devices**.

### **Cloud Provider Modules**
| Provider | Module |
|----------|--------|
| AWS | `amazon.aws.ec2_instance` |
| Azure | `azure.azcollection.azure_rm` |
| GCP | `google.cloud.gcp_compute` |
| Kubernetes | `community.kubernetes.k8s` |

### **Example: Creating an AWS EC2 Instance**
```yaml
- name: Launch an EC2 instance
  amazon.aws.ec2_instance:
    name: my-instance
    key_name: my-key
    instance_type: t2.micro
    image_id: ami-12345678
    region: us-east-1
    count: 1
    network:
      assign_public_ip: true
```

---

## Using Ansible with Terraform

Ansible is often used alongside Terraform to configure infrastructure after provisioning.

### **Terraform Provisions, Ansible Configures**
1. Terraform creates VMs.
2. Ansible installs and configures software on them.

### **Example: Running Ansible After Terraform**
```hcl
resource "null_resource" "configure_server" {
  provisioner "local-exec" {
    command = "ansible-playbook -i inventory.ini site.yml"
  }
}
```

---

## Creating Custom Ansible Modules

If built-in modules are not enough, you can create **custom modules** using Python.

### **Basic Python Ansible Module (`custom_module.py`)**
```python
#!/usr/bin/python
from ansible.module_utils.basic import AnsibleModule

def main():
    module = AnsibleModule(
        argument_spec={
            "name": {"type": "str", "required": True}
        }
    )
    name = module.params["name"]
    module.exit_json(changed=True, message=f"Hello, {name}!")

if __name__ == "__main__":
    main()
```

### **Using the Custom Module in a Playbook**
```yaml
- name: Run custom module
  custom_module:
    name: "Ansible User"
```
