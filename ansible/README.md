## Ansible

**Ansible** is an open-source **configuration management, provisioning, and automation** tool that enables **agentless** infrastructure automation using SSH, WinRM, and APIs.

- **Official Docs**: [https://docs.ansible.com/](https://docs.ansible.com/)
- **GitHub Repository**: [https://github.com/ansible/ansible](https://github.com/ansible/ansible)
- **Ansible Galaxy (Roles & Collections)**: [https://galaxy.ansible.com/](https://galaxy.ansible.com/)
- **Best Practices Guide**: [https://docs.ansible.com/ansible/latest/user_guide/playbooks_best_practices.html](https://docs.ansible.com/ansible/latest/user_guide/playbooks_best_practices.html)

---

### Dictionary (Key Ansible Terms)

- **Playbook**: A YAML file defining automation tasks to be executed on target hosts.
- **Inventory**: A file or dynamic script listing hosts managed by Ansible.
- **Module**: Predefined functionality used in playbooks (e.g., `apt`, `yum`, `copy`, `shell`).
- **Task**: A single action executed on a host (e.g., install a package).
- **Role**: A structured way to organize playbooks, variables, templates, and handlers.
- **Collection**: A set of roles, modules, and plugins packaged together.
- **Facts**: System information gathered automatically (`ansible_facts`).
- **Handlers**: Special tasks triggered by events (e.g., restart a service after an update).

---

### CRDs (Custom Resource Definitions)

Ansible **does not use Kubernetes CRDs**,  
but **Ansible Operator** can manage Kubernetes resources using **Ansible playbooks** instead of Go-based controllers.

For Kubernetes-native automation, see [Ansible Operator](https://github.com/operator-framework/operator-sdk/blob/master/doc/ansible/operator.md).

---
