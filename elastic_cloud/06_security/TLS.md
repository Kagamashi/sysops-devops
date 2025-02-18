# Elasticsearch TLS and Encryption Options

## **1. Introduction to TLS in Elasticsearch**
Transport Layer Security (**TLS**) ensures secure communication **between Elasticsearch nodes**, **clients**, and **Kibana** by encrypting data in transit. In **Elastic Cloud**, TLS is enabled **by default**, but for self-managed clusters, it requires manual configuration.

### **Key Benefits:**
- **Prevents man-in-the-middle attacks**.
- **Ensures compliance** with security best practices.
- **Encrypts traffic** between Elasticsearch, Kibana, and other clients.

---

## **2. Enabling TLS for Self-Managed Elasticsearch Clusters**
For on-premise or self-hosted deployments, TLS must be configured manually.

### **Step 1: Generate Certificates Using `elasticsearch-certutil`**
```sh
bin/elasticsearch-certutil cert --keep-ca-key
```
This generates:
- **CA certificate (`elastic-stack-ca.p12`)**
- **Node certificates (`elastic-certificates.p12`)**

### **Step 2: Configure `elasticsearch.yml` to Enable TLS**
```yaml
xpack.security.enabled: true
xpack.security.transport.ssl.enabled: true
xpack.security.transport.ssl.keystore.path: "certs/elastic-certificates.p12"
xpack.security.transport.ssl.truststore.path: "certs/elastic-certificates.p12"
```

### **Step 3: Restart Elasticsearch**
```sh
systemctl restart elasticsearch
```
Verify TLS is working:
```sh
curl --cacert certs/elastic-stack-ca.pem https://localhost:9200
```

---

## **3. Enabling TLS for HTTP Communication**
To encrypt API and client connections (e.g., Kibana, Beats, custom apps), configure TLS for **Elasticsearch’s HTTP layer**.

### **Modify `elasticsearch.yml`**
```yaml
xpack.security.http.ssl.enabled: true
xpack.security.http.ssl.keystore.path: "certs/elastic-certificates.p12"
xpack.security.http.ssl.truststore.path: "certs/elastic-certificates.p12"
```
Restart Elasticsearch:
```sh
systemctl restart elasticsearch
```

Verify using a **secure connection**:
```sh
curl --cacert certs/elastic-stack-ca.pem https://localhost:9200
```

---

## **4. Using Custom Certificates and Domains**
By default, Elasticsearch uses auto-generated certificates, but you may need **custom domain certificates** for trusted public access.

### **Step 1: Obtain a Trusted Certificate**
- Use a public **Certificate Authority (CA)** (e.g., **Let's Encrypt, DigiCert, GlobalSign**).
- Or generate your own using **OpenSSL**:
  ```sh
  openssl req -x509 -newkey rsa:4096 -keyout key.pem -out cert.pem -days 365
  ```

### **Step 2: Configure Elasticsearch for Custom Certs**
```yaml
xpack.security.http.ssl.keystore.path: "certs/custom-cert.p12"
xpack.security.http.ssl.truststore.path: "certs/custom-cert.p12"
```

### **Step 3: Configure Kibana to Use TLS**
Modify `kibana.yml`:
```yaml
server.ssl.enabled: true
server.ssl.certificate: certs/custom-cert.pem
server.ssl.key: certs/custom-key.pem
elasticsearch.ssl.certificateAuthorities: ["certs/ca.pem"]
```
Restart Kibana:
```sh
systemctl restart kibana
```

---

## **5. Verifying TLS Configuration**
### **Check TLS Settings in Elasticsearch**
```sh
GET _nodes/settings?filter_path=**.ssl
```
### **Test Secure API Access**
```sh
curl --cacert certs/ca.pem https://elasticsearch.example.com:9200
```
### **Check Certificate Validity**
```sh
openssl s_client -connect elasticsearch.example.com:9200 -CAfile certs/ca.pem
```

---

## **6. Best Practices for TLS in Elasticsearch**
- **Use TLS for both transport and HTTP layers**.
- **Regularly rotate certificates** to ensure security.
- **Use a trusted CA** for production environments.
- **Enable strict certificate validation** to prevent unauthorized access.
- **Automate certificate renewal** using Let's Encrypt or other tools.

For more details, visit **[Elasticsearch Security Guide](https://www.elastic.co/guide/en/elasticsearch/reference/current/security-settings.html)**.
