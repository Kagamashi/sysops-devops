# VPC and Subnets

## 1. Overview
Google Cloud Virtual Private Cloud (VPC) is a **global, scalable, and software-defined network** that allows secure communication between cloud resources. It supports **custom and auto-mode subnets, firewall rules, routes, and cross-project networking.**

---

## 2. VPC Basics
A **VPC network** is a **global resource** in GCP that spans all regions and allows connectivity between resources within the project or across projects via Shared VPC.

### **Key Features**
- **Global scope** – VPC networks are not limited to a single region.
- **Subnet flexibility** – Can be **auto-mode** (default subnets) or **custom-mode** (manual subnet configuration).
- **Private communication** – Use **private IPs** to connect cloud services securely.
- **Cross-project connectivity** – Supports **Shared VPC** for centralizing networking across projects.

```sh
gcloud compute networks create my-vpc \
  --subnet-mode=custom
```

---

## 3. Subnets (Auto vs Custom)

### **1. Auto-mode Subnets (Default)**
- Automatically creates a **/20 subnet in each region**.
- Simplifies network management for multi-region workloads.
- Not ideal for enterprises needing precise CIDR control.

### **2. Custom-mode Subnets**
- Manual control over **subnet CIDR ranges and region placement**.
- Required for **Hybrid connectivity (VPN, Interconnect, Private Google Access).**
- Preferred for **secure, production-grade environments.**

```sh
gcloud compute networks subnets create my-subnet \
  --network=my-vpc \
  --range=10.0.1.0/24 \
  --region=us-central1
```

---

## 4. Firewall Rules
Firewall rules control **ingress and egress traffic** to VMs and resources inside a VPC.

### **Default Behavior**
- **Implicit deny-all ingress** – No inbound traffic unless explicitly allowed.
- **Allow all egress traffic** by default.

### **Example: Allow SSH Traffic**
```sh
gcloud compute firewall-rules create allow-ssh \
  --network=my-vpc \
  --allow=tcp:22 \
  --source-ranges=0.0.0.0/0
```

### **Example: Restrict Internal Traffic**
```sh
gcloud compute firewall-rules create deny-internal \
  --network=my-vpc \
  --direction=INGRESS \
  --deny=all \
  --source-ranges=10.0.0.0/8
```

---

## 5. Routes
Routes define how traffic flows within the VPC or to external destinations.

### **Types of Routes**
| **Type**      | **Description** |
|--------------|----------------|
| **Subnet Route** | Automatically created for each subnet. |
| **Static Route** | Manually defined custom route. |
| **Dynamic Route** | Uses **Cloud Router** to exchange routes dynamically. |

### **Example: Creating a Static Route**
```sh
gcloud compute routes create my-static-route \
  --network=my-vpc \
  --destination-range=192.168.1.0/24 \
  --next-hop-gateway=default-internet-gateway
```

---

## 6. Shared VPC & Cross-Project Networking

### **1. Shared VPC**
- Allows **multiple projects** to share a central VPC network.
- Improves security by keeping networking **managed centrally**.
- Reduces administrative overhead for hybrid cloud setups.

```sh
gcloud compute shared-vpc enable my-host-project
```

### **2. Cross-Project Networking (VPC Peering)**
- Directly connects **VPC networks across different projects**.
- Lower latency and higher security than **external VPN solutions**.

```sh
gcloud compute networks peerings create my-vpc-peering \
  --network=my-vpc \
  --peer-project=my-peer-project \
  --peer-network=my-peer-vpc
```

---

## 7. Final Checklist
✅ Use **custom-mode subnets** for better control over IP ranges.
✅ Implement **firewall rules** to restrict access and improve security.
✅ Define **static routes** only when necessary to avoid routing conflicts.
✅ Use **Shared VPC** for centralized networking across projects.
✅ Prefer **VPC Peering** over VPN for better performance and security.

📌 **More Resources:** [Google Cloud VPC Documentation](https://cloud.google.com/vpc/docs/)
