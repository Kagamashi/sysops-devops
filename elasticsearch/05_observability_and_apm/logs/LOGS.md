
## **Shipping Logs to Elasticsearch**
Logs can be collected using **Filebeat**, **Elastic Agent**, or **custom log ingestion methods**.

### **Using Filebeat to Ship Logs**
1. **Install Filebeat** on the target system:
   ```sh
   curl -L -O https://artifacts.elastic.co/downloads/beats/filebeat/filebeat-8.x-linux-x86_64.tar.gz
   tar xzvf filebeat-8.x-linux-x86_64.tar.gz
   ```
2. **Enable Modules** (e.g., system logs, Nginx, Apache):
   ```sh
   filebeat modules enable system nginx apache
   ```
3. **Configure Filebeat Output to Elasticsearch** (edit `filebeat.yml`):
   ```yaml
   output.elasticsearch:
     hosts: ["http://elasticsearch:9200"]
     username: "elastic"
     password: "changeme"
   ```
4. **Start Filebeat**:
   ```sh
   filebeat -e
   ```

### **Using Elastic Agent for Logs & Metrics**
1. **Install Elastic Agent**:
   ```sh
   curl -L -O https://artifacts.elastic.co/downloads/beats/elastic-agent/elastic-agent-8.x-linux-x86_64.tar.gz
   tar xzvf elastic-agent-8.x-linux-x86_64.tar.gz
   ```
2. **Enroll in Fleet (Kibana UI required)**:
   ```sh
   elastic-agent install --url=https://kibana:5601 --enrollment-token=<TOKEN>
   ```
3. **Enable Log Sources in Fleet**:
   - Navigate to **Kibana → Fleet**.
   - Add **Integrations** like **System Logs, Docker Logs, Nginx, etc.**.

---
