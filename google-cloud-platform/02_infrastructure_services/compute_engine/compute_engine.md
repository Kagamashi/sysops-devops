# Compute Engine

## 1. Overview
Google Compute Engine (GCE) provides scalable, high-performance virtual machines (VMs) on Google Cloud. It supports a variety of workloads with flexible provisioning, autoscaling, and automated recovery features.

---

## 2. VM Provisioning
VM provisioning in Compute Engine allows users to create instances with predefined or custom configurations.

### **Provisioning Methods**
- **Google Cloud Console** – UI-based instance creation.
- **gcloud CLI** – Command-line interface for scripting deployments.
- **Terraform** – Infrastructure as Code (IaC) automation.
- **API & SDKs** – Programmatic instance creation.

### **Example: Creating a VM via gcloud CLI**
```sh
 gcloud compute instances create my-vm \
  --machine-type=e2-standard-4 \
  --image-family=debian-11 \
  --image-project=debian-cloud \
  --zone=us-central1-a
```

---

## 3. Instance Groups
Instance Groups allow VM management at scale, providing automation for HA and scalability.

### **Types of Instance Groups**
| **Type**                  | **Description** |
|--------------------------|--------------------------------------------------------------|
| **Managed Instance Group (MIG)** | Auto-scaling, auto-healing, and rolling updates. Recommended for stateless applications. |
| **Unmanaged Instance Group (UIG)** | Manually managed VM instances. Suitable for workloads requiring full control. |

### **Example: Creating a Managed Instance Group**
```sh
gcloud compute instance-groups managed create my-mig \
  --base-instance-name=my-instance \
  --size=3 \
  --template=my-instance-template \
  --zone=us-central1-a
```

---

## 4. Autohealing
Autohealing in Managed Instance Groups (MIGs) ensures that failed instances are automatically restarted or replaced.

### **Autohealing Mechanism**
- Uses **health checks** to monitor instance status.
- If an instance is unhealthy, it is automatically restarted.
- Works in conjunction with load balancing and autoscaling.

### **Example: Enabling Autohealing in MIG**
```sh
gcloud compute instance-groups managed update my-mig \
  --health-check=my-health-check \
  --zone=us-central1-a
```

---

## 5. Instance Templates
Instance Templates define configurations for new VM instances, ensuring consistency and simplifying scaling.

### **Key Attributes in an Instance Template**
- **Machine type** (CPU, memory)
- **Boot disk** (OS image, custom image)
- **Networking** (VPC, firewall rules)
- **Metadata** (Startup scripts, labels)

### **Example: Creating an Instance Template**
```sh
gcloud compute instance-templates create my-template \
  --machine-type=e2-standard-4 \
  --image-family=debian-11 \
  --image-project=debian-cloud \
  --tags=http-server \
  --metadata=startup-script="#!/bin/bash echo Hello World"
```

---

## 6. OS Images and Custom Images
Google Compute Engine provides pre-configured OS images as well as the ability to create and use custom images.

### **OS Image Options**
- **Public Images**: Maintained by Google (e.g., Debian, Ubuntu, Windows, Red Hat).
- **Custom Images**: User-created images based on configured VMs.
- **Container-Optimized OS**: Optimized for container workloads.

### **Creating a Custom Image from an Existing Disk**
```sh
gcloud compute images create my-custom-image \
  --source-disk=my-disk \
  --source-disk-zone=us-central1-a
```

### **Listing Available OS Images**
```sh
gcloud compute images list --project=debian-cloud
```

---

## 7. Final Checklist
✅ Use **Managed Instance Groups (MIGs)** for autohealing and autoscaling.
✅ Define **Instance Templates** for consistency in deployments.
✅ Enable **Autohealing** with health checks for better uptime.
✅ Use **Custom Images** to optimize VM deployments.
✅ Automate VM provisioning with **gcloud CLI, Terraform, or API**.

📌 **More Resources:** [Google Compute Engine Documentation](https://cloud.google.com/compute/docs/)

