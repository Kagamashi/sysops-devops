
## **Centralized Logging with EFK Stack (Elasticsearch, Fluentd, Kibana)**

### **1. Fluentd (Log Collector & Forwarder)**
- Collects logs from containers and forwards them to Elasticsearch.

### **2. Elasticsearch (Storage & Indexing)**
- Stores structured log data for querying.

### **3. Kibana (Visualization & Analysis)**
- Provides dashboards and query capabilities for logs.

#### **Deploying EFK Stack**
```bash
kubectl apply -f https://raw.githubusercontent.com/kubernetes/kubernetes/master/cluster/addons/fluentd-elasticsearch/es-statefulset.yaml
kubectl apply -f https://raw.githubusercontent.com/kubernetes/kubernetes/master/cluster/addons/fluentd-elasticsearch/kibana-deployment.yaml
kubectl apply -f https://raw.githubusercontent.com/kubernetes/kubernetes/master/cluster/addons/fluentd-elasticsearch/fluentd-es-daemonset.yaml
```

---
