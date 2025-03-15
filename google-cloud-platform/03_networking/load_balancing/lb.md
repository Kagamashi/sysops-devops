# Load Balancing and Proxies

## 1. Overview
Google Cloud provides a suite of **load balancers and proxies** to distribute traffic efficiently across resources, ensuring scalability, high availability, and security. Load balancers support **HTTP(S), TCP, and UDP traffic** while integrating with security features like **SSL certificates and Cloud Armor**.

---

## 2. Load Balancing Types
Google Cloud offers both **global and regional** load balancers for different use cases.

### **1. HTTP(S) Load Balancer (Global)**
- Fully managed **Layer 7 load balancer**.
- Uses **Google's global network** to route traffic to the nearest healthy backend.
- Supports **Cloud CDN, SSL/TLS termination, and Web Application Firewall (WAF) with Cloud Armor**.

```sh
gcloud compute backend-services create my-backend \
  --global \
  --protocol=HTTP
```

### **2. Internal vs External Load Balancers**
| **Load Balancer Type** | **Traffic Type** | **Scope** | **Use Case** |
|------------------------|------------------|-----------|--------------|
| **External HTTP(S)** | HTTP(S) | Global | Public-facing web applications |
| **Internal HTTP(S)** | HTTP(S) | Regional | Intranet applications |
| **TCP Proxy** | TCP | Global | Non-HTTP workloads with global reach |
| **UDP Load Balancer** | UDP | Regional | Gaming, VoIP, real-time apps |

---

## 3. Configuring Load Balancers

### **1. HTTP(S) Load Balancer (External)**
- Used for serving **public-facing web applications**.
- Supports **SSL certificates, autoscaling, and logging**.

```sh
gcloud compute url-maps create my-url-map \
  --default-service=my-backend
```

```sh
gcloud compute target-http-proxies create my-http-proxy \
  --url-map=my-url-map
```

### **2. Internal Load Balancer**
- Used for **private services within a VPC**.
- Supports **health checks and backend instances**.

```sh
gcloud compute forwarding-rules create my-ilb \
  --load-balancing-scheme=internal \
  --backend-service=my-internal-backend \
  --region=us-central1
```

---

## 4. SSL Certificates
SSL certificates secure connections by encrypting traffic between clients and the load balancer.

### **Types of SSL Certificates**
- **Managed SSL** – Automatically provisioned by Google.
- **Self-Managed SSL** – Custom certificates provided by the user.

```sh
gcloud compute ssl-certificates create my-managed-cert \
  --domains=mydomain.com \
  --global
```

---

## 5. Cloud Armor for Web Security
Cloud Armor is a **Web Application Firewall (WAF)** that provides protection against **DDoS attacks, SQL injection, and XSS**.

### **Configuring Cloud Armor**
- Allows **IP-based filtering and Geo-blocking**.
- Protects **Google Cloud Load Balancers**.

```sh
gcloud compute security-policies create my-security-policy
```

```sh
gcloud compute security-policies rules create 100 \
  --security-policy=my-security-policy \
  --src-ip-ranges=203.0.113.0/24 \
  --action=deny
```

---

## 6. Final Checklist
✅ Choose the **appropriate load balancer** based on traffic type.
✅ Use **HTTP(S) Load Balancer** for global web applications.
✅ Enable **Cloud Armor** to protect against web attacks.
✅ Use **Managed SSL certificates** for automatic renewal.
✅ Configure **health checks** to ensure backend availability.

📌 **More Resources:** [Google Cloud Load Balancing Documentation](https://cloud.google.com/load-balancing/docs/)
