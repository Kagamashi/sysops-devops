# Elasticsearch Audit Logging and Compliance

## **1. Introduction to Audit Logging in Elasticsearch**
Elasticsearch **audit logging** provides detailed tracking of security events, user activities, and system changes. It is essential for **compliance with regulations** like **GDPR, HIPAA, and SOC 2**.

### **Key Benefits:**
- Logs **authentication, authorization, and access events**.
- Helps in **forensic analysis and compliance auditing**.
- Tracks **modifications to user roles, indices, and cluster settings**.

---

## **2. Enabling Audit Logging in Elasticsearch**
Audit logging is part of **X-Pack Security** and must be enabled manually.

### **Step 1: Modify `elasticsearch.yml` to Enable Audit Logging**
```yaml
xpack.security.audit.enabled: true
xpack.security.audit.logfile.events.include: [ "authentication_success", "authentication_failed", "access_granted", "access_denied", "run_as_granted" ]
xpack.security.audit.outputs: ["logfile"]
```
### **Step 2: Restart Elasticsearch**
```sh
systemctl restart elasticsearch
```
Verify audit logging:
```sh
cat /var/log/elasticsearch/audit.log
```

---

## **3. Common Compliance Scenarios Using Audit Logs**
Audit logs help organizations meet **security and compliance standards**.

### **Scenario 1: User Access Monitoring (SOC 2, ISO 27001)**
- Detect unauthorized access attempts.
- Log successful/failed logins and privilege escalations.
- Query example:
  ```json
  GET _security/_authenticate
  ```

### **Scenario 2: Data Access Auditing (GDPR, HIPAA)**
- Track who accessed specific documents.
- Detect **excessive data export activities**.
- Example audit log:
  ```json
  {
    "type": "access_denied",
    "user": "john_doe",
    "index": "patient-records",
    "reason": "Unauthorized query"
  }
  ```

### **Scenario 3: Role Changes & Privilege Escalation (PCI-DSS)**
- Track admin role modifications.
- Identify suspicious permission changes.
- Example detection query:
  ```json
  GET _security/role
  ```

---

## **4. Audit Log Storage and Rotation**
Audit logs can grow rapidly, so **proper storage and rotation strategies** are necessary.

### **Configuring Audit Log Retention**
Modify `elasticsearch.yml` to configure log rotation:
```yaml
xpack.security.audit.logfile.rollover: "daily"
xpack.security.audit.logfile.retention: "7d"
```
This retains logs for **7 days**, rotating them **daily**.

### **Archiving Logs to External Storage**
Use **Logstash or Beats** to forward logs to long-term storage:
```yaml
output.elasticsearch:
  hosts: ["https://audit-logs.elasticsearch.com"]
  index: "audit-logs-%{+YYYY.MM.dd}"
```

---

## **5. Best Practices for Audit Logging and Compliance**
- **Enable only necessary audit events** to reduce log volume.
- **Use external log storage** (e.g., S3, SIEM solutions) for long-term retention.
- **Regularly review logs** for security threats and compliance audits.
- **Automate alerts** for privilege changes and failed logins.
- **Ensure log integrity** using SHA-based log signing.

For more details, visit **[Elasticsearch Security Documentation](https://www.elastic.co/guide/en/elasticsearch/reference/current/security-settings.html)**.
