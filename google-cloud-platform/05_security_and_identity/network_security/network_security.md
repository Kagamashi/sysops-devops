# Network Security Controls

## 1. Overview
Google Cloud provides **network security controls** to protect resources and manage access within Virtual Private Cloud (VPC) networks. These include **VPC firewall rules, Cloud Armor for DDoS protection and Web Application Firewall (WAF), Private Google Access, and private endpoints**.

---

## 2. VPC Firewall Rules
VPC firewall rules **control ingress and egress traffic** to Google Cloud resources. These rules apply at the **VPC level** and allow for fine-grained traffic filtering.

### **Key Features**
- Default **deny-all ingress** rule (must explicitly allow traffic).
- Default **allow-all egress** rule (outbound traffic is unrestricted).
- Supports **allow and deny rules** based on IP ranges, protocols, and ports.

### **Creating a Firewall Rule to Allow SSH**
```sh
gcloud compute firewall-rules create allow-ssh \
  --network=my-vpc \
  --allow=tcp:22 \
  --source-ranges=0.0.0.0/0
```

### **Creating a Firewall Rule to Restrict Internal Traffic**
```sh
gcloud compute firewall-rules create deny-internal \
  --network=my-vpc \
  --direction=INGRESS \
  --deny=all \
  --source-ranges=10.0.0.0/8
```

---

## 3. Cloud Armor (DDoS Protection & WAF)
Cloud Armor provides **DDoS mitigation and Web Application Firewall (WAF)** capabilities to protect Google Cloud workloads.

### **Key Features**
- Protects against **layer 3/4 DDoS attacks** (e.g., SYN floods, UDP reflection).
- Provides **custom WAF rules** for OWASP threats like SQL injection and XSS.
- Supports **geo-based blocking and IP whitelisting**.

### **Creating a Security Policy with Cloud Armor**
```sh
gcloud compute security-policies create my-security-policy
```

### **Blocking Traffic from Specific IP Ranges**
```sh
gcloud compute security-policies rules create 100 \
  --security-policy=my-security-policy \
  --src-ip-ranges=203.0.113.0/24 \
  --action=deny
```

### **Applying Cloud Armor to an HTTP Load Balancer**
```sh
gcloud compute backend-services update my-backend \
  --security-policy=my-security-policy --global
```

---

## 4. Private Google Access
Private Google Access allows **VM instances without external IPs** to access Google APIs and services via **private IP addresses**.

### **Use Cases**
- Securely access **Cloud Storage, BigQuery, and other managed services**.
- Prevent data exfiltration by blocking internet access.
- Enforce **network security best practices**.

### **Enabling Private Google Access on a Subnet**
```sh
gcloud compute networks subnets update my-subnet \
  --enable-private-ip-google-access --region=us-central1
```

---

## 5. Private Endpoints
Private endpoints allow access to Google services using **internal IP addresses** within a VPC, avoiding exposure to the public internet.

### **Key Features**
- Uses **Private Service Connect** for secure service consumption.
- Supports **Cloud SQL, Memorystore, and other managed services**.
- Ensures **data never traverses the public internet**.

### **Creating a Private Endpoint for Cloud SQL**
```sh
gcloud compute addresses create my-private-ip \
  --region=us-central1 \
  --subnet=my-subnet
```

### **Creating a Private Connection to a Service**
```sh
gcloud services vpc-peerings connect \
  --service=servicenetworking.googleapis.com \
  --network=my-vpc \
  --ranges=my-private-ip
```

---

## 6. Final Checklist
✅ Use **VPC firewall rules** to control traffic flow securely.
✅ Deploy **Cloud Armor** for DDoS protection and WAF security.
✅ Enable **Private Google Access** to securely access Google services.
✅ Implement **private endpoints** for Cloud SQL, Storage, and APIs.
✅ Regularly **audit firewall and security policies** for compliance.

📌 **More Resources:** [Google Cloud Security Documentation](https://cloud.google.com/security/)

