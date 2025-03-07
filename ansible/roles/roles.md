# Ansible Roles and Reusability

## Roles Basics

Ansible **roles** allow users to organize automation tasks into reusable components. They help keep playbooks clean and modular.

### **What is an Ansible Role?**
A role is a **self-contained directory** that includes tasks, variables, handlers, templates, and other resources required to configure a system.

### **Creating a New Role**
Use `ansible-galaxy` to generate a role structure:
```bash
ansible-galaxy init myrole
```
This creates the following directory structure:
```
myrole/
├── tasks/        # Main list of tasks to execute
│   ├── main.yml  # Entry point for tasks
├── handlers/     # Handlers triggered by notify
│   ├── main.yml
├── templates/    # Jinja2 template files
├── files/        # Static files to copy
├── vars/         # Variables with higher precedence
│   ├── main.yml
├── defaults/     # Default variables (lowest precedence)
│   ├── main.yml
├── meta/         # Role metadata (dependencies, authorship)
│   ├── main.yml
├── README.md     # Documentation
```

---

## Directory Structure of Roles

### **Breakdown of Key Role Components**
| Directory | Purpose |
|-----------|---------|
| `tasks/` | Defines the actual tasks executed by the role |
| `handlers/` | Stores handlers that respond to changes (e.g., restarting services) |
| `templates/` | Contains Jinja2 templates for dynamic configurations |
| `files/` | Static files copied to managed nodes |
| `vars/` | Stores high-priority variables |
| `defaults/` | Stores default role variables (overridable) |
| `meta/` | Defines dependencies and role metadata |

### **Example `tasks/main.yml` (Installing and Starting Nginx)**
```yaml
- name: Install Nginx
  apt:
    name: nginx
    state: present

- name: Start Nginx
  service:
    name: nginx
    state: started
```

### **Example `handlers/main.yml` (Restart Nginx if Needed)**
```yaml
- name: Restart Nginx
  service:
    name: nginx
    state: restarted
```

---

## Using Existing Ansible Galaxy Roles

Ansible Galaxy is a repository of prebuilt roles.

### **Installing a Role from Ansible Galaxy**
```bash
ansible-galaxy install geerlingguy.nginx
```

### **Using an Installed Role in a Playbook**
```yaml
- name: Configure Web Server
  hosts: webservers
  roles:
    - geerlingguy.nginx
```
