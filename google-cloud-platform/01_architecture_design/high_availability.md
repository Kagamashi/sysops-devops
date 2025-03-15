# GCP High Availability (HA) & Disaster Recovery (DR)

## 1. Overview
High availability ensures minimal downtime, while disaster recovery focuses on restoring services after failures. GCP offers **regional and multi-regional** architectures to meet different **RTO (Recovery Time Objective) & RPO (Recovery Point Objective)** requirements.

## 2. Regional vs Multi-Regional Services
Google Cloud provides both **regional** (single-region) and **multi-regional** (cross-region) services. Choosing the right architecture depends on the business's tolerance for downtime and data loss.

### **Comparison Table**
| **Category**        | **Regional (Single Region)**     | **Multi-Regional (Cross-Region)** |
|--------------------|---------------------------------|----------------------------------|
| **Compute**       | Compute Engine Zonal/Regional, GKE Zonal | GKE Regional, Cloud Run Multi-Region |
| **Storage**       | Cloud Storage (Standard, Nearline) | Cloud Storage Multi-Region, Filestore Multi-Region |
| **Databases**     | Cloud SQL (HA), Bigtable | Spanner Multi-Region, BigQuery |
| **Networking**    | Internal Load Balancer | Global Load Balancer (Anycast) |
| **Messaging**     | Pub/Sub Regional | Pub/Sub Lite Multi-Region |

### **Guidelines for Choosing**
- **Use Multi-Region Services** for business-critical workloads with near-zero downtime.
- **Enable HA for Regional Services** (e.g., Cloud SQL HA, GKE Regional Clusters) when possible.
- **Choose Global Load Balancing** for cross-region traffic distribution.

## 3. Cross-Region Replication Strategies
Replication ensures data is available in multiple regions for **fault tolerance** and **disaster recovery**.

### **Replication Mechanisms**
| **Service**       | **Replication Mechanism** | **Best Use Case** |
|------------------|--------------------------|-------------------|
| **Cloud Storage** | Multi-Region Buckets (Automatic) | Geo-distributed storage |
| **Cloud SQL** | Cross-Region Read Replicas | Low-latency read workloads |
| **Spanner** | Multi-Region Deployment (Synchronous) | Global transactional workloads |
| **BigQuery** | Multi-Region Dataset (Automatic) | Multi-regional data analytics |
| **GKE** | Multi-Cluster (Federation) | Active-Active workloads |

### **Best Practices**
- **Cloud SQL HA**: Use **read replicas** in different regions for redundancy.
- **Spanner Multi-Region**: Provides **strong consistency** across global deployments.
- **GKE Regional Clusters**: Distributes nodes across zones to avoid single-zone failures.

## 4. Backup & Restore Strategies
A solid backup and restore strategy is essential for disaster recovery. Google Cloud provides multiple ways to back up data across different services.

### **1. Compute Backup (VM Snapshots)**
- Use **scheduled snapshots** for Compute Engine disks.
- Store backups in a **different region** than the primary.
- Automate backups using **Cloud Scheduler**.

### **2. Database Backup**
- **Cloud SQL**: Enable **automated backups & point-in-time recovery (PITR)**.
- **Bigtable**: Use **Cloud Storage exports** for backups.
- **Spanner**: Backup with **daily snapshots + retention policies**.

### **3. Object Storage Backup**
- **Cloud Storage**: Use **Lifecycle Rules** to archive/delete old backups.
- **Multi-region Buckets**: Store critical backups with automatic redundancy.
- **Coldline/Nearline Storage**: Reduce costs for infrequently accessed backups.

### **4. Kubernetes Backup**
- Use **Velero** for GKE backups.
- Store **persistent volume (PV) snapshots** in Cloud Storage.
