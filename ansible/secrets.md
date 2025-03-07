# Ansible Security and Secrets Management

## Ansible Vault Basics

Ansible Vault allows encrypting sensitive data such as passwords, API keys, and configuration files.

### **Encrypting a File**
To encrypt a file (e.g., `secrets.yml`):
```bash
ansible-vault encrypt secrets.yml
```

### **Editing an Encrypted File**
```bash
ansible-vault edit secrets.yml
```

### **Decrypting a File**
```bash
ansible-vault decrypt secrets.yml
```

### **Using Vault-encrypted Variables in Playbooks**
```yaml
vars:
  db_password: !vault |
          $ANSIBLE_VAULT;1.1;AES256
          326635373162346432623432...
```

Run the playbook with the vault password:
```bash
ansible-playbook site.yml --ask-vault-pass
```

---

## Managing SSH Keys and Authentication

### **Generating SSH Keys**
```bash
ssh-keygen -t rsa -b 4096 -C "ansible-user"
```

### **Copying the Key to a Remote Host**
```bash
ssh-copy-id user@remote_host
```

### **Using Ansible to Distribute SSH Keys**
```yaml
- name: Deploy SSH key
  authorized_key:
    user: ansible
    state: present
    key: "{{ lookup('file', '~/.ssh/id_rsa.pub') }}"
```

---

## Secrets Storage Best Practices

### **Using External Secrets Managers**
| Tool | Integration |
|------|------------|
| **HashiCorp Vault** | `community.hashi_vault` module |
| **AWS Secrets Manager** | `amazon.aws.aws_secret` module |
| **Kubernetes Secrets** | `community.kubernetes.k8s` module |

### **Example: Fetching Secrets from HashiCorp Vault**
```yaml
- name: Get secret from Vault
  community.hashi_vault.vault_read:
    url: "https://vault.example.com"
    path: "secret/data/db_password"
    auth_method: token
  register: vault_secret

- name: Use secret in a task
  debug:
    msg: "Database password is {{ vault_secret.data.data.password }}"
```

AzureKeyVault example: https://learn.microsoft.com/en-us/azure/developer/ansible/key-vault-configure-secrets?tabs=ansible
