# Cloud Storage

## 1. Overview
Google Cloud Storage provides **scalable, secure, and durable object storage** for a wide range of use cases, from backups to serving high-traffic websites. It supports multiple storage classes, lifecycle management policies, and cost optimization techniques.

---

## 2. Buckets
Buckets are the **top-level containers** for storing objects in Cloud Storage. Each bucket is associated with a **storage class, location, and access control settings**.

### **Creating a Bucket**
```sh
gcloud storage buckets create my-bucket \
  --location=us-central1 \
  --storage-class=STANDARD
```

### **Listing Buckets**
```sh
gcloud storage buckets list
```

### **Deleting a Bucket**
```sh
gcloud storage buckets delete my-bucket
```

---

## 3. Storage Classes
Cloud Storage offers **four storage classes** to optimize performance and cost based on access frequency.

| **Storage Class** | **Best For** | **Availability** | **Cost** |
|------------------|-------------|----------------|----------|
| **Standard** | Frequent access, low latency | High | Highest |
| **Nearline** | Access ~once per month | High | Lower than Standard |
| **Coldline** | Access ~once per year | Medium | Lower than Nearline |
| **Archive** | Long-term archival, rare access | Lower | Lowest |

### **Changing Storage Class of an Object**
```sh
gcloud storage objects rewrite gs://my-bucket/my-object \
  gs://my-bucket/my-object \
  --storage-class=COLDLINE
```

---

## 4. Lifecycle Management
Lifecycle policies **automate object transitions** between storage classes and define retention periods before deletion.

### **Example: Configure Lifecycle Policy**
```json
{
  "rule": [
    {
      "action": { "type": "SetStorageClass", "storageClass": "COLDLINE" },
      "condition": { "age": 30 }
    },
    {
      "action": { "type": "Delete" },
      "condition": { "age": 365 }
    }
  ]
}
```

```sh
gcloud storage buckets update my-bucket \
  --lifecycle-file=lifecycle.json
```

---

## 5. Performance & Cost Optimization

### **Performance Tips**
- Use **regional buckets** for lower latency.
- Enable **Cloud CDN** for frequently accessed content.
- Utilize **Parallel Composite Uploads** for large files.

### **Cost Optimization Strategies**
- Store **cold data in Coldline or Archive storage**.
- Implement **lifecycle policies** to automatically transition storage classes.
- **Use Object Versioning** selectively to avoid unnecessary costs.

---

## 6. Final Checklist
✅ Choose the **appropriate storage class** based on access frequency.
✅ Implement **lifecycle policies** to automate storage class transitions.
✅ Enable **Cloud CDN** for performance improvements on static assets.
✅ Optimize costs by **storing infrequently accessed data in Nearline/Coldline/Archive**.
✅ Secure access with **IAM roles, signed URLs, and bucket policies**.

📌 **More Resources:** [Google Cloud Storage Documentation](https://cloud.google.com/storage/docs/)
