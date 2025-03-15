# DNS and Network Services

## 1. Overview
Google Cloud provides **DNS and network services** to manage domain names, optimize content delivery, and steer traffic efficiently. Key services include **Cloud DNS (public and private zones), Cloud CDN for caching, traffic steering, and IP address management**.

---

## 2. Cloud DNS
Cloud DNS is a **scalable, managed Domain Name System (DNS) service** that supports **public and private DNS zones**.

### **1. Public DNS Zones**
- Used for **internet-facing domains**.
- Supports **custom domain mappings** for Cloud Run, App Engine, and Load Balancers.
- High availability with **Anycast routing**.

```sh
gcloud dns managed-zones create my-public-zone \
  --dns-name=mydomain.com \
  --description="Public DNS zone" \
  --visibility=public
```

### **2. Private DNS Zones**
- Used for **internal networking within a VPC**.
- Supports **service discovery** for internal workloads.
- Can be **linked to multiple VPCs**.

```sh
gcloud dns managed-zones create my-private-zone \
  --dns-name=corp.internal \
  --description="Private DNS zone" \
  --visibility=private \
  --networks=my-vpc
```

---

## 3. Cloud CDN (Content Delivery Network)
Cloud CDN **caches content at Google’s global edge locations**, reducing latency and improving load times.

### **Key Features**
- **Global caching** for faster content delivery.
- **SSL/TLS termination** at the edge.
- **Origin fetch optimization** using HTTP/2.

### **Enabling Cloud CDN for a Backend Service**
```sh
gcloud compute backend-buckets create my-cdn-bucket \
  --bucket-name=my-storage-bucket \
  --enable-cdn
```

---

## 4. Traffic Steering
Traffic steering allows intelligent **routing of traffic** across different backend services based on **geo-location, latency, or weight-based policies**.

### **1. Weighted Routing**
- Used for **gradual rollouts and A/B testing**.
- Routes traffic between different backend versions.

```sh
gcloud compute url-maps create my-url-map \
  --default-service=my-backend-v1

gcloud compute url-maps add-path-matcher my-url-map \
  --path-matcher-name=split-traffic \
  --default-service=my-backend-v2 \
  --backend-service-weight=my-backend-v1=70,my-backend-v2=30
```

### **2. Geo-based Routing**
- Routes users to **regionally optimized backends**.
- Improves **latency and compliance with data residency laws**.

```sh
gcloud compute backend-services update my-backend \
  --global \
  --custom-request-header="X-Geo-Region: us-east1"
```

---

## 5. IP Address Management
Google Cloud provides **static and ephemeral IPs** for external and internal resources.

### **1. Reserving a Static External IP**
```sh
gcloud compute addresses create my-static-ip \
  --region=us-central1
```

### **2. Reserving a Static Internal IP for VMs**
```sh
gcloud compute addresses create my-internal-ip \
  --region=us-central1 \
  --subnet=my-subnet \
  --addresses=10.0.1.100
```

### **3. Assigning an IP to a VM Instance**
```sh
gcloud compute instances create my-vm \
  --zone=us-central1-a \
  --address=my-static-ip
```

---

## 6. Final Checklist
✅ Use **public DNS zones** for internet-facing applications.
✅ Configure **private DNS zones** for internal service discovery.
✅ Enable **Cloud CDN** for faster content delivery.
✅ Implement **traffic steering** for better performance and testing.
✅ Manage **static IPs** for stable resource connectivity.

📌 **More Resources:** [Google Cloud DNS Documentation](https://cloud.google.com/dns/docs/)

