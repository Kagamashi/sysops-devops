# Getting Started with Ansible

## What is Ansible?

Ansible is an **open-source IT automation tool** that simplifies **configuration management, application deployment, and infrastructure orchestration**. It allows users to automate repetitive tasks across multiple systems efficiently.

### **Key Features of Ansible:**
- **Agentless** – No need to install software on target machines (uses SSH).
- **Declarative** – Define the desired system state, and Ansible ensures it.
- **Idempotent** – Runs tasks only when needed, preventing unintended changes.
- **YAML-based Playbooks** – Simple, human-readable automation scripts.
- **Extensible** – Supports custom modules, plugins, and integrations.

### **Common Use Cases:**
| Use Case | Description |
|----------|-------------|
| **Configuration Management** | Automate OS, package, and service configurations. |
| **Application Deployment** | Deploy and update applications consistently. |
| **Infrastructure Provisioning** | Set up servers, networks, and cloud resources. |
| **Orchestration** | Automate complex workflows across multiple hosts. |
| **Security Automation** | Enforce security policies and compliance rules. |

### **How Ansible Works:**
1. **Control Node** – The machine where Ansible runs (e.g., your laptop or CI/CD server).
2. **Managed Nodes** – Target systems (Linux, Windows, cloud instances, network devices).
3. **Inventory** – A list of managed nodes.
4. **Playbooks** – YAML files that define automation tasks.
5. **Modules** – Pre-built commands that execute actions on remote machines.

Ansible connects to managed nodes over SSH (or WinRM for Windows) and executes tasks **without requiring an agent** on the target machines.

---

## Directory Structure

Ansible projects typically follow this structure:
```
ansible-project/
├── ansible.cfg      # Configuration file (optional)
├── inventory        # Hosts inventory file
├── playbooks/       # Playbooks directory
│   ├── site.yml     # Main playbook
│   ├── webserver.yml # Playbook for web servers
│   ├── database.yml # Playbook for database servers
├── roles/           # Reusable Ansible roles
│   ├── common/      # Common configuration role
│   ├── webserver/   # Web server configuration role
│   ├── database/    # Database configuration role
```

### **Breakdown of Key Files**
| File/Directory | Purpose |
|---------------|---------|
| `ansible.cfg` | Configuration file for Ansible settings |
| `inventory` | Defines remote hosts for Ansible to manage |
| `playbooks/` | Contains YAML playbooks with automation logic |
| `roles/` | Stores reusable roles for better modularity |

This setup ensures **modular, scalable, and maintainable** Ansible automation.

---

Next, we'll cover **Inventory and Configuration** in detail!
