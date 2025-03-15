# Cloud Operations Stack

## 1. Overview
Google Cloud Operations (formerly Stackdriver) provides **monitoring, logging, and observability** tools to help organizations maintain system health, detect anomalies, and respond to issues effectively. The key components include **Cloud Monitoring and Cloud Logging**.

---

## 2. Cloud Monitoring
Cloud Monitoring enables collection, visualization, and alerting on **metrics and system health** across Google Cloud services.

### **Key Features**
- **Custom and system metrics** for Compute Engine, GKE, Cloud SQL, etc.
- **Uptime checks** to monitor external and internal endpoints.
- **Alerting policies** for proactive issue resolution.

### **1. Viewing Metrics in Cloud Monitoring**
```sh
gcloud monitoring metrics list
```

### **2. Creating an Uptime Check**
```sh
gcloud monitoring uptime-checks create http my-uptime-check \
  --path="/health" \
  --port=443 \
  --host=my-service.com \
  --regions=us-central1
```

### **3. Creating an Alert Policy**
```sh
gcloud monitoring policies create \
  --notification-channels=my-channel \
  --conditions="metric.type=compute.googleapis.com/instance/cpu/utilization threshold=0.8"
```

---

## 3. Cloud Logging
Cloud Logging collects, stores, and analyzes logs from **Google Cloud services, applications, and infrastructure**.

### **Key Features**
- **Log Sinks**: Export logs to Cloud Storage, Pub/Sub, or BigQuery.
- **Log-Based Metrics**: Create custom metrics from log data.
- **Integration with Cloud Monitoring** for alerts based on log events.

### **1. Viewing Logs in Cloud Logging**
```sh
gcloud logging logs list --project=my-project
```

### **2. Creating a Log Sink (Export to Cloud Storage)**
```sh
gcloud logging sinks create my-log-sink \
  storage.googleapis.com/my-log-bucket \
  --log-filter="resource.type=gce_instance"
```

### **3. Creating a Log-Based Metric**
```sh
gcloud logging metrics create my-error-metric \
  --description="Counts error logs" \
  --log-filter="severity=ERROR"
```

---

## 4. Final Checklist
✅ Enable **Cloud Monitoring** to track system performance and application health.  
✅ Set up **uptime checks and alerts** for proactive issue detection.  
✅ Use **log sinks** to export logs for analysis and long-term storage.  
✅ Create **log-based metrics** to monitor key log patterns.  
✅ Regularly **review alerts and refine thresholds** for accuracy.  

📌 **More Resources:** [Google Cloud Operations Documentation](https://cloud.google.com/products/operations)

