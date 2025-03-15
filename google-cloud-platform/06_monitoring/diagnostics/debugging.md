# Diagnostics and Debugging

## 1. Overview
Google Cloud provides various **diagnostic and debugging tools** to help developers identify and resolve issues efficiently. Key services include **Error Reporting, Cloud Trace, Cloud Profiler, and structured logging best practices**.

---

## 2. Error Reporting
Error Reporting automatically **detects, aggregates, and notifies** about errors in applications running on Google Cloud.

### **Key Features**
- **Automatic error detection** from logs.
- **Real-time alerts** for new error occurrences.
- **Grouping and deduplication** of errors for easy tracking.

### **Viewing Errors in Error Reporting**
```sh
gcloud beta logging read "logName:projects/my-project/logs/appengine.googleapis.com%2Frequest_log AND severity>=ERROR"
```

### **Setting Up Notifications for Errors**
```sh
gcloud beta error-reporting groups update my-error-group \
  --add-notification-channel=my-channel
```

---

## 3. Cloud Trace
Cloud Trace helps analyze and optimize application latency by providing **distributed tracing across services**.

### **Key Features**
- Captures **end-to-end request latency** across services.
- Helps **identify performance bottlenecks**.
- Provides **integration with Cloud Logging and Monitoring**.

### **Enabling Cloud Trace**
```sh
gcloud services enable cloudtrace.googleapis.com --project=my-project
```

### **Viewing Trace Data**
```sh
gcloud beta trace list-traces --start-time "2023-01-01T00:00:00Z"
```

---

## 4. Cloud Profiler
Cloud Profiler provides **continuous profiling of CPU and memory usage** to help optimize application performance.

### **Key Features**
- Identifies **hotspots in code** causing high CPU/memory consumption.
- Supports **low-overhead sampling** for minimal impact on production.
- Provides **visual reports and call graphs**.

### **Enabling Cloud Profiler**
```sh
gcloud services enable cloudprofiler.googleapis.com --project=my-project
```

### **Integrating Cloud Profiler in a Python App**
```python
import googlecloudprofiler

googlecloudprofiler.start(service='my-service', service_version='1.0.0')
```

---

## 5. Structured Logging Best Practices
Structured logging improves the **searchability and analysis** of logs in Cloud Logging.

### **Best Practices**
✅ Use **JSON format logs** for better query capabilities.  
✅ Attach **request IDs** to correlate logs across services.  
✅ Set **log severity levels** (`INFO`, `ERROR`, `DEBUG`).  
✅ Use **labels and metadata** for filtering and indexing logs.  

### **Example: Logging a Structured JSON Entry**
```python
import json
import logging

log_data = {
    "severity": "ERROR",
    "message": "Database connection failed",
    "context": {"request_id": "1234-abcd"}
}

logging.info(json.dumps(log_data))
```

---

## 6. Final Checklist
✅ Enable **Error Reporting** to track and manage application issues.  
✅ Use **Cloud Trace** to analyze request latency.  
✅ Enable **Cloud Profiler** to optimize resource consumption.  
✅ Follow **structured logging best practices** for efficient debugging.  
✅ Regularly review **alerts and profiling data** to improve performance.  

📌 **More Resources:** [Google Cloud Debugging Tools](https://cloud.google.com/products/operations)