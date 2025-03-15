# IAM and Organization Structure

## 1. Overview
Google Cloud Identity and Access Management (IAM) provides **fine-grained access control** and resource management through **roles, policies, and service accounts**. It integrates with the **GCP resource hierarchy**, ensuring structured access control across organizations, folders, and projects.

---

## 2. GCP Resource Hierarchy
Google Cloud resources are organized in a **hierarchical structure** that facilitates security, policy enforcement, and access control.

### **Hierarchy Levels**
| **Level**         | **Description** |
|------------------|----------------|
| **Organization** | The root node that represents a company or domain. |
| **Folder** | Logical grouping of projects for easier management. |
| **Project** | Contains cloud resources like Compute Engine, Cloud Storage, and BigQuery. |
| **Resources** | Individual cloud services within a project. |

### **Example: Listing Organization ID**
```sh
gcloud organizations list
```

### **Example: Creating a Folder in an Organization**
```sh
gcloud resource-manager folders create --display-name="Dev Team" --organization=1234567890
```

---

## 3. IAM Roles
IAM roles define **permissions** for users, groups, and service accounts at different levels in the resource hierarchy.

### **1. Basic Roles (Deprecated for Fine-Grained Control)**
- **Owner** – Full control, including billing.
- **Editor** – Modify resources but no billing access.
- **Viewer** – Read-only access.

### **2. Predefined Roles**
- Google-managed roles for **specific services** (e.g., `roles/storage.objectViewer` for Cloud Storage).
- Used for **least privilege access**.

### **3. Custom Roles**
- Created when predefined roles are insufficient.
- Assigned at **organization, folder, or project level**.

```sh
gcloud iam roles create myCustomRole \
  --project=my-project \
  --title="Custom Role" \
  --permissions=compute.instances.start,compute.instances.stop
```

---

## 4. Service Accounts
Service accounts are **machine identities** used for authentication between services.

### **Key Features**
- Can be **assigned IAM roles** like human users.
- Used by **applications, VMs, and workloads** to access Google Cloud resources.
- Supports **key-based authentication**.

### **Creating a Service Account**
```sh
gcloud iam service-accounts create my-service-account \
  --display-name="My Service Account"
```

### **Granting Permissions to a Service Account**
```sh
gcloud projects add-iam-policy-binding my-project \
  --member="serviceAccount:my-service-account@my-project.iam.gserviceaccount.com" \
  --role="roles/storage.admin"
```

---

## 5. Workload Identity
Workload Identity allows **Kubernetes workloads to use IAM identities securely** instead of relying on long-lived service account keys.

### **Enabling Workload Identity on GKE**
```sh
gcloud container clusters update my-cluster \
  --identity-namespace=my-project.svc.id.goog
```

### **Assigning IAM Roles to a Kubernetes Service Account**
```sh
gcloud iam service-accounts add-iam-policy-binding my-service-account@my-project.iam.gserviceaccount.com \
  --role=roles/iam.workloadIdentityUser \
  --member="serviceAccount:my-project.svc.id.goog[mynamespace/myksa]"
```

---

## 6. Final Checklist
✅ Use **folders** to organize projects by department or function.
✅ Assign **least privilege roles** to prevent over-permissioning.
✅ Use **service accounts** for application authentication.
✅ Enable **Workload Identity** for Kubernetes workloads.
✅ Regularly audit **IAM policies** for security best practices.

📌 **More Resources:** [Google Cloud IAM Documentation](https://cloud.google.com/iam/docs/)

