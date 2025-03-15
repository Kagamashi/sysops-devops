## 5. Disaster Recovery (DR) Tiers
Different disaster recovery strategies offer varying levels of **cost, RTO, and RPO**.

### **Comparison Table**
| **DR Strategy**   | **RTO (Recovery Time)** | **RPO (Data Loss Tolerance)** | **Cost** | **Example Services** |
|------------------|----------------------|----------------------|---------|--------------------|
| **Backup & Restore** | Hours | Hours | Low | Snapshots, Database Backups |
| **Warm Standby** | Minutes | Minutes | Medium | Cloud SQL Read Replicas, BigQuery Multi-Region |
| **Active-Active (HA)** | Seconds | Near 0 | High | Spanner Multi-Region, Global Load Balancer |

### **Best Practices**
- **Use automated snapshots** for fast recovery.
- **Geo-redundant storage** protects against regional failures.
- **Deploy GKE clusters across multiple regions** for **true HA**.

📌 **More Resources:** [Google Cloud DR Guide](https://cloud.google.com/architecture/disaster-recovery)
