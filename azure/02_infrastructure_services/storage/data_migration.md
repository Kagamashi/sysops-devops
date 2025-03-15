# Azure Migration Options

## Azure Migrate

Azure Migrate is a **migration hub** that helps you **assess and migrate** on-premises infrastructure, applications, and data to Azure.

### Features:
- **Unified Migration Platform** – A single portal to manage the entire migration process.
- **Integrated Tools**:
  - **Azure Migrate: Discovery and Assessment** – Identifies on-premises servers running on VMware, Hyper-V, or physical hardware.
  - **Azure Migrate: Server Migration** – Migrates VMs (VMware, Hyper-V, physical servers, public cloud VMs).
  - **Data Migration Assistant** – Assesses SQL Servers for compatibility and migration paths.
  - **Azure Database Migration Service** – Moves databases to **Azure SQL**, **SQL Server on VMs**, or **SQL Managed Instances**.
  - **Azure App Service Migration Assistant** – Assesses and migrates .NET and PHP web apps to **Azure App Service**.

---

## Azure Data Box

Azure Data Box is a **physical migration service** designed for **large-scale data transfers** where network connectivity is limited or slow.

### Features:
- **Secure, rugged storage device** with up to **80 TB** usable capacity.
- **Shipped via a regional carrier** for data transfer.
- **Supports both import and export** of data to/from Azure.
- **Data automatically uploaded** once the device is returned to Microsoft.

### Use Cases:
#### **Importing Data to Azure**
- **One-time migration** – Move large datasets (e.g., media libraries, VM farms, historical data).
- **Initial bulk transfer** – Use Data Box to seed large data volumes, followed by incremental network transfers.
- **Periodic uploads** – Transfer large datasets generated on a regular basis.

#### **Exporting Data from Azure**
- **Disaster recovery** – Restore large amounts of Azure data to an on-premises network.
- **Security compliance** – Export sensitive data to meet regulatory requirements.
- **Cloud migration rollback** – Move workloads back on-premises or to another cloud provider.

### Security:
- **Data is securely erased** from the device once uploaded to Azure (following **NIST 800-88r1** standards).
- For export orders, the **disks are wiped** when the device reaches the Azure datacenter.

---

## Choosing the Right Migration Approach

| **Migration Need** | **Recommended Approach** |
|--------------------|-------------------------|
| **VM & server migration** | Azure Migrate: Server Migration |
| **Database migration** | Azure Database Migration Service |
| **Web app migration** | Azure App Service Migration Assistant |
| **Large-scale offline data transfer** | Azure Data Box |
| **SQL Server assessment** | Data Migration Assistant |
