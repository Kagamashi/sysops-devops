# Elasticsearch User Management and Roles

## **1. Introduction to User Management in Elasticsearch**
Elasticsearch provides **Role-Based Access Control (RBAC)** to manage user permissions securely. Users and roles can be configured to restrict data access, control index operations, and integrate with **Single Sign-On (SSO)** solutions like SAML or OAuth.

### **Key Features:**
- **Built-in and custom roles** for granular access control.
- **User authentication via Elasticsearch, LDAP, SAML, or OpenID Connect**.
- **API and Kibana UI for managing users and roles**.

---

## **2. Creating Roles and Assigning Privileges**
Roles define what actions a user or service can perform within Elasticsearch.

### **Creating a Role via Kibana UI**
1. Navigate to **Kibana → Stack Management → Security → Roles**.
2. Click **Create Role** and define:
   - **Cluster privileges** (e.g., manage_index_templates, monitor, manage_ml)
   - **Index privileges** (e.g., read, write, manage)
   - **Kibana privileges** (e.g., dashboard-only, full access)
3. Click **Save Role**.

### **Creating a Role via API**
```json
PUT _security/role/logs_reader
{
  "cluster": ["monitor"],
  "indices": [
    {
      "names": ["logs-*"],
      "privileges": ["read"]
    }
  ]
}
```

### **Assigning a Role to a User**
```json
POST _security/user/john_doe
{
  "password": "SecurePass!",
  "roles": ["logs_reader"],
  "full_name": "John Doe",
  "email": "john@example.com"
}
```

---

## **3. Built-in vs. Custom Roles**
Elasticsearch provides **built-in roles** for common tasks but allows **custom role creation** for specific needs.

### **Comparison Table**
| Type | Description | Examples |
|------|------------|----------|
| **Built-in Roles** | Predefined roles with common privileges. | `superuser`, `kibana_admin`, `read_only` |
| **Custom Roles** | User-defined roles for fine-grained control. | `logs_reader`, `ml_analyst`, `readonly_user` |

---

## **Best Practices for User and Role Management**
- **Use least privilege** principles—assign only necessary permissions.
- **Regularly audit roles** to ensure security compliance.
- **Enable SAML or OpenID Connect** for centralized authentication.
- **Rotate credentials periodically** for enhanced security.
- **Monitor failed login attempts** to detect unauthorized access.

For more details, visit **[Elasticsearch Security Documentation](https://www.elastic.co/guide/en/elasticsearch/reference/current/security-settings.html)**.
