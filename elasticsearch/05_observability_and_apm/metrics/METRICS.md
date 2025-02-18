
## **Collecting Metrics with Metricbeat**
Metricbeat is used to collect system and service metrics (CPU, memory, disk usage, etc.).

### **Installing and Configuring Metricbeat**
1. **Install Metricbeat**:
   ```sh
   curl -L -O https://artifacts.elastic.co/downloads/beats/metricbeat/metricbeat-8.x-linux-x86_64.tar.gz
   tar xzvf metricbeat-8.x-linux-x86_64.tar.gz
   ```
2. **Enable Modules** (e.g., system, Kubernetes, Docker):
   ```sh
   metricbeat modules enable system docker kubernetes
   ```
3. **Configure Output to Elasticsearch** (`metricbeat.yml`):
   ```yaml
   output.elasticsearch:
     hosts: ["http://elasticsearch:9200"]
   ```
4. **Start Metricbeat**:
   ```sh
   metricbeat -e
   ```

---
