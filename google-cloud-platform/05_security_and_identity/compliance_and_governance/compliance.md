# Compliance and Governance

## 1. Overview
Google Cloud provides **compliance and governance tools** to help organizations enforce security policies, manage access, and maintain auditability. Key services include **Resource Manager, policy constraints, organization policies, audit logs, and Access Transparency**.

---

## 2. GCP Resource Hierarchy
Google Cloud organizes resources into a hierarchical structure to simplify **policy enforcement and access control**.

### **Hierarchy Levels**
| **Level**          | **Description** |
|-------------------|----------------|
| **Organization**  | The root node representing a company or domain. |
| **Folders**       | Logical groups for projects, useful for departments or teams. |
| **Projects**      | The base unit where resources (VMs, databases, etc.) reside. |
| **Resources**     | Individual cloud services within a project. |

### **Example: Listing Organization ID**
```sh
gcloud organizations list
```

### **Creating a Folder in an Organization**
```sh
gcloud resource-manager folders create --display-name="Finance" --organization=1234567890
```

---

## 3. Organization Policies & Policy Constraints
Organization policies allow administrators to **enforce security and compliance rules** across all projects in an organization.

### **Key Features**
- **Prevent unsafe configurations** (e.g., restricting external IPs on VMs).
- **Apply policies at the org, folder, or project level**.
- **Inheritance model** ensures child resources comply with higher-level policies.

### **Example: Restricting External IPs on VM Instances**
```sh
gcloud org-policies set-policy policy.yaml
```

#### **Example `policy.yaml` to Deny External IPs**
```yaml
constraint: constraints/compute.vmExternalIpAccess
listPolicy:
  deniedValues:
    - "*"
```

---

## 4. Audit Logs
Google Cloud **Audit Logs** track administrative, system, and data access actions across cloud resources.

### **Types of Audit Logs**
| **Log Type**          | **Purpose** |
|----------------------|------------|
| **Admin Activity**   | Tracks changes to cloud configurations and IAM policies. |
| **Data Access**      | Monitors reads and writes to GCP resources. |
| **System Events**    | Captures internal system operations. |
| **Policy Denied**    | Logs policy violations. |

### **Viewing Audit Logs for a Project**
```sh
gcloud logging logs list --project=my-project
```

### **Querying Audit Logs in Cloud Logging**
```sh
gcloud logging read "logName:projects/my-project/logs/cloudaudit.googleapis.com%2Factivity"
```

---

## 5. Access Transparency
Access Transparency provides **real-time visibility** into Google Cloud administrative actions on your resources.

### **Key Benefits**
- **Tracks Google Cloud support and engineering access** to customer environments.
- Ensures **regulatory compliance** by providing detailed logs.
- Can be **enabled on eligible services** such as BigQuery and Compute Engine.

### **Enabling Access Transparency**
```sh
gcloud organizations update 1234567890 --set-access-transparency-logs=ENABLED
```

---

## 6. Final Checklist
✅ Use **Organization Policies** to enforce security standards.
✅ Structure **resources with folders** for better governance.
✅ Enable **Audit Logs** to monitor administrative and data access events.
✅ Enable **Access Transparency** for visibility into Google’s administrative actions.
✅ Regularly **review IAM policies and security settings** to ensure compliance.

📌 **More Resources:** [Google Cloud Governance Documentation](https://cloud.google.com/resource-manager/docs/)

