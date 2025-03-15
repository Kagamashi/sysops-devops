# Azure Storage Accounts

Azure Storage is a **highly scalable** service that offers multiple data services (blobs, files, queues, and tables) for storing, managing, and accessing data in the cloud.

## 1. What Is Azure Storage?
- A Microsoft cloud solution for storing **files, messages, tables**, and other data.
- Supports:
  - **VM data** (disks, files)
  - **Unstructured data** (Blob Storage, Data Lake Storage)
  - **Structured data** (Azure Table, Cosmos DB, SQL)

## 2. Storage Account Types

## Storage Account Types
| **Type**                    | **Supported Services**                                               | **Redundancy Options**                | **Usage**                                                                                                                                                       |
|-----------------------------|----------------------------------------------------------------------|----------------------------------------|----------------------------------------------------------------------------------------------------------------------------------------------------------------|
| **Standard general-purpose v2** | Blob, Queue, Table, Azure Files                                    | LRS, GRS, RA-GRS, ZRS, GZRS, RA-GZRS    | - Standard storage for most scenarios.<br>- Recommended for blobs, file shares, queues, tables.<br>- Use premium file shares type if you need NFS in Azure Files. |
| **Premium block blobs**     | Blob Storage (incl. Data Lake Storage)                               | LRS, ZRS                                | - Premium for block/append blobs.<br>- Ideal for high transaction rates, small objects, or low-latency needs.                                                  |
| **Premium file shares**     | Azure Files                                                          | LRS, ZRS                                | - Premium for file shares.<br>- Suited for enterprise or high-performance applications.<br>- Supports SMB and NFS file shares.                                  |
| **Premium page blobs**      | Page blobs only                                                      | LRS                                    | - Premium for page blobs only.                                                                                                                                |

> **Note**: You cannot directly convert a Standard storage account to Premium or vice versa.

| **Storage Service**            | **Endpoint Format**                                                   |
|--------------------------------|----------------------------------------------------------------------|
| **Blob Storage**               | `https://<storage-account-name>.blob.core.windows.net`                |
| **Data Lake Storage Gen2**     | `https://<storage-account-name>.dfs.core.windows.net`                 |
| **Azure Files**                | `https://<storage-account-name>.file.core.windows.net`                |
| **Queue Storage**              | `https://<storage-account-name>.queue.core.windows.net`               |
| **Table Storage**              | `https://<storage-account-name>.table.core.windows.net`               |


## 3. Azure Storage Data Services

### 3.1 Blob Storage
- Stores **unstructured data** (text/binary).
- Ideal for:
  - Serving images/documents
  - Streaming video/audio
  - Backup and restore
  - Data analysis
- Access via HTTP(S), REST API, PowerShell, Azure CLI, or client libraries.

### 3.2 Azure Files
- **Managed file shares** in the cloud (SMB or NFS protocols).
- Multiple VMs can **share the same files** (read/write).
- Useful for migrating on-prem apps that rely on file shares.

### 3.3 Queue Storage
- **Message storage** for asynchronous workflows.
- Can store millions of messages (up to 64 KB each).
- Often used to **decouple** components (e.g., image processing, thumbnail creation).

### 3.4 Table Storage
- Stores **nonrelational structured data** (NoSQL)
- Key/attribute store with a **schemaless design**.
- **Low-cost, high throughput** for big data scenarios.
- Also available via **Cosmos DB Table API**.

## 4. Durability & Availability (Replication Options)

| Replication   | Description                                                                             | Use Cases                                                  |
|---------------|-----------------------------------------------------------------------------------------|------------------------------------------------------------|
| **LRS**       | Locally redundant. 3 copies in 1 data center.                                           | Cost-effective, but lower durability if DC is lost.        |
| **ZRS**       | Zone redundant. 3 copies in 3 zones within 1 region.                                    | Protects from zonal outages, good performance.             |
| **GRS**       | Geo-redundant. LRS + async replication to secondary region.                             | High durability, accessible if MS fails over region.       |
| **RA-GRS**    | Read-access GRS. GRS + read from secondary region anytime.                              | Read replicas for DR scenarios.                            |
| **GZRS**      | Geo-zone redundant. ZRS + async replication to secondary region.                        | Combines ZRS resilience with geo-redundancy.               |
| **RA-GZRS**   | Read-access GZRS. GZRS + read from secondary region.                                    | Highest durability, read from secondary region.            |

**Recommended**:
- Use **GZRS** for critical apps requiring durability & availability.
- Enable **RA-GZRS** if read access from a secondary region is needed.

## 5. Service Endpoints & Access
- Every storage object has a unique **URL**: `<storage-account-name>.<service>.core.windows.net`.
- Custom domain mapping with **CNAME** records possible.
- Restrict network access via **Firewalls and virtual networks** in the portal.
- Public IP ranges and specific subnets can be allowed.

## 6. Key Considerations
- **Durability & Availability**: Automatic replication across data centers/zones.
- **Security**: All data encrypted at rest, fine-grained access controls.
- **Scalability**: Massively scalable for modern workloads.
- **Manageability**: Hardware maintenance, updates handled by Azure.
- **Data Accessibility**: Access from anywhere via HTTP/HTTPS, multiple language SDKs.

---

**Azure Storage** is a foundational service for many solutions—enabling secure, durable, and massively scalable data storage for various use cases.

