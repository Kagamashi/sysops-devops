# Cloud KMS and Secret Manager

## 1. Overview
Google Cloud provides **Cloud Key Management Service (KMS)** for encryption key management and **Secret Manager** for storing sensitive application secrets securely. These services help manage cryptographic keys, control access, and ensure compliance with security best practices.

---

## 2. Cloud Key Management Service (KMS)
Cloud KMS allows organizations to **create, manage, and rotate encryption keys** for securing sensitive data.

### **Types of Encryption Keys**
| **Key Type**      | **Description** |
|------------------|----------------|
| **Symmetric Keys** | Used for fast encryption/decryption with a single key. Ideal for **Cloud Storage, Databases, and Compute Engine Disks**. |
| **Asymmetric Keys** | Uses separate public and private keys. Suitable for **digital signatures and secure authentication**. |

### **Creating a Key Ring and Key**
```sh
gcloud kms keyrings create my-keyring --location=global
```
```sh
gcloud kms keys create my-key \
  --location=global \
  --keyring=my-keyring \
  --purpose=encryption
```

### **Encrypting Data with KMS**
```sh
echo "my secret data" | gcloud kms encrypt \
  --location=global \
  --keyring=my-keyring \
  --key=my-key \
  --plaintext-file=- \
  --ciphertext-file=ciphertext.bin
```

### **Decrypting Data with KMS**
```sh
gcloud kms decrypt \
  --location=global \
  --keyring=my-keyring \
  --key=my-key \
  --ciphertext-file=ciphertext.bin \
  --plaintext-file=plaintext.txt
```

---

## 3. Secret Manager
Secret Manager provides **secure storage for API keys, passwords, certificates, and other sensitive data**.

### **Key Features**
- **Versioned secrets** to track changes.
- **IAM-based access control** for enhanced security.
- **Automatic replication** across regions for high availability.

### **Creating and Storing a Secret**
```sh
gcloud secrets create my-secret --replication-policy=automatic
```
```sh
echo -n "my-secret-value" | gcloud secrets versions add my-secret --data-file=-
```

### **Retrieving a Secret**
```sh
gcloud secrets versions access latest --secret=my-secret
```

### **Deleting a Secret**
```sh
gcloud secrets delete my-secret
```

---

## 4. Best Practices for Key and Secret Management

### **1. Key Management Best Practices**
✅ Use **Cloud KMS for centralized key management**.
✅ Implement **key rotation policies** to minimize security risks.
✅ Restrict access using **IAM policies** and **least privilege principles**.
✅ Enable **audit logging** to monitor key usage.

### **2. Secret Management Best Practices**
✅ Store **secrets in Secret Manager instead of environment variables**.
✅ Implement **automatic secret rotation** for security compliance.
✅ Restrict access to secrets using **IAM roles**.
✅ Enable **Secret Manager audit logs** to track access history.

📌 **More Resources:** [Google Cloud KMS Documentation](https://cloud.google.com/kms/docs/) | [Google Secret Manager Documentation](https://cloud.google.com/secret-manager/docs/)

