## High Availability and Disaster Recovery (HADR) in Azure

### Recovery Time Objective (RTO) and Recovery Point Objective (RPO)
- **RTO:** Maximum time allowed to restore resources after an outage.
- **RPO:** Maximum acceptable data loss, defining how far back data recovery should go.
- **Key Considerations:**
  - Define RTO/RPO based on business requirements.
  - Consider cost vs. downtime impact.
  - Ensure alignment of RTO/RPO across application components.

### High Availability and Disaster Recovery (HADR) for SQL Server

#### **Infrastructure as a Service (IaaS) vs. Platform as a Service (PaaS)**
- **IaaS:** SQL Server VMs provide full control over HADR configurations.
- **PaaS:** Built-in HADR features with minimal configuration.

#### **SQL Server HADR Features in Azure**
| Feature | Protection Level |
|---------|----------------|
| Always On Failover Cluster Instance (FCI) | Instance |
| Always On Availability Group (AG) | Database |
| Log Shipping | Database |

### **Availability Solutions for SQL Server on Azure VMs**
1. **Always On Failover Cluster Instances (FCI)**
   - Protects entire SQL Server instance.
   - Requires shared storage (Azure Shared Disk, iSCSI, etc.).
   - Requires Active Directory and DNS.
   
2. **Always On Availability Groups (AGs)**
   - Protects databases.
   - Provides multiple replicas with synchronous/asynchronous replication.
   - Requires cluster infrastructure.
   
3. **Log Shipping**
   - Simple backup-based replication.
   - Works in environments with high latency or limited connectivity.
   
### **Azure High Availability and Disaster Recovery Options**
| Solution | Purpose |
|----------|---------|
| Availability Sets | Protects against single data center failures. |
| Availability Zones | Protects against entire Azure region failures. |
| Azure Site Recovery | Replicates entire VMs across regions for DR. |
| Geo-Replication (PaaS) | Ensures database replication across regions. |

### **IaaS High Availability and Disaster Recovery Architectures**
1. **Single Region HA - Always On Availability Groups**
   - Ensures data redundancy within a region.
   - Supports read-only replicas for offloading workloads.
   
2. **Multi-Region or Hybrid Availability Groups**
   - Extends HA and DR across multiple Azure regions.
   - Requires robust network connectivity.
   
3. **Distributed Availability Groups**
   - Uses separate clusters to improve resiliency.
   - Provides an AG of AGs for improved failover scenarios.
   
4. **Log Shipping for DR**
   - Periodic log backups provide simple DR replication.
   - Works well in environments with limited resources.
   
5. **Azure Site Recovery (ASR)**
   - Provides full VM replication.
   - Useful for non-SQL workloads requiring DR.

### **Hybrid HADR Solutions**
- Combines on-premises and Azure for robust DR solutions.
- Requires careful network planning (e.g., ExpressRoute, VPNs).
- Supports backup storage in Azure as a cost-effective DR option.

By implementing these Azure HADR strategies, organizations can minimize downtime, reduce data loss, and ensure resilience against outages and failures.

