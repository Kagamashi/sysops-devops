# Kubernetes Engine (GKE)

## 1. Overview
Google Kubernetes Engine (GKE) is a managed Kubernetes service that simplifies container orchestration, scaling, and operations. It supports both zonal and regional clusters, various networking modes, and security best practices.

---

## 2. Cluster Creation (Zonal vs Regional)

### **Zonal Clusters**
- Nodes exist in a **single zone**.
- Lower cost, but less fault-tolerant.
- Suitable for **development and test workloads**.

### **Regional Clusters**
- Nodes spread across **multiple zones** in a region.
- Higher availability and resilience.
- Recommended for **production workloads**.

### **Example: Creating a Zonal GKE Cluster**
```sh
gcloud container clusters create my-cluster \
  --zone us-central1-a \
  --num-nodes 3
```

### **Example: Creating a Regional GKE Cluster**
```sh
gcloud container clusters create my-cluster \
  --region us-central1 \
  --num-nodes 3 \
  --enable-autorepair \
  --enable-autoupgrade
```

---

## 3. Node Pools
Node pools allow flexible node configurations within a GKE cluster.

### **Best Practices**
- Use **preemptible nodes** for cost optimization.
- Assign **dedicated node pools** for specific workloads (e.g., GPU, high-memory nodes).
- Enable **auto-repair and auto-upgrade** for security and stability.

### **Example: Creating a Node Pool**
```sh
gcloud container node-pools create my-node-pool \
  --cluster my-cluster \
  --machine-type e2-standard-4 \
  --num-nodes 3 \
  --zone us-central1-a
```

---

## 4. Autoscaling in GKE
GKE supports multiple autoscaling mechanisms to optimize resource utilization.

### **1. Cluster Autoscaler**
- Automatically scales the number of nodes in a node pool based on demand.
- Works with **Node Pools**.

```sh
gcloud container clusters update my-cluster \
  --enable-autoscaling \
  --min-nodes=1 --max-nodes=5 \
  --zone us-central1-a
```

### **2. Horizontal Pod Autoscaler (HPA)**
- Scales the number of pod replicas based on CPU or custom metrics.

```sh
kubectl autoscale deployment my-deployment \
  --cpu-percent=80 --min=2 --max=10
```

### **3. Vertical Pod Autoscaler (VPA)**
- Adjusts pod resource requests and limits dynamically.

```sh
kubectl apply -f vpa-config.yaml
```

---

## 5. GKE Networking Modes

### **1. VPC-Native Mode (Recommended)**
- Uses Google Cloud **Alias IPs**.
- Provides **better scalability** and **simplified network policies**.
- Supports **Pod-to-Service and Pod-to-Pod communication**.

```sh
gcloud container clusters create my-cluster \
  --enable-ip-alias \
  --subnetwork my-subnet
```

### **2. Routes-Based Mode (Legacy)**
- Uses **static routes** for Pod networking.
- Less scalable and harder to manage.
- Not recommended for new deployments.

---

## 6. GKE Security Best Practices

### **1. Identity and Access Management (IAM)**
- Assign **least privilege IAM roles** to GKE users.
- Use **Workload Identity** instead of Kubernetes secrets.

```sh
gcloud container clusters update my-cluster \
  --workload-pool=my-project.svc.id.goog
```

### **2. Network Security**
- Enable **private clusters** to restrict access to the public internet.
- Use **Google Cloud Armor** to protect against DDoS attacks.

```sh
gcloud container clusters create my-private-cluster \
  --enable-private-nodes \
  --master-ipv4-cidr=172.16.0.0/28
```

### **3. Pod Security Policies & RBAC**
- Restrict privileged containers with **PodSecurityPolicies**.
- Use **Role-Based Access Control (RBAC)** to manage permissions.

```sh
kubectl create rolebinding my-rolebinding \
  --role=my-role \
  --user=my-user
```

---

## 7. Final Checklist
✅ Use **regional clusters** for production workloads.
✅ Enable **Cluster Autoscaler, HPA, and VPA** for efficient scaling.
✅ Prefer **VPC-native networking** for better scalability.
✅ Secure clusters with **IAM, Workload Identity, and private nodes**.
✅ Implement **RBAC and Pod Security Policies** for least privilege access.

📌 **More Resources:** [GKE Documentation](https://cloud.google.com/kubernetes-engine/docs/)

