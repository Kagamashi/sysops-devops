# Performance Monitoring and Tuning

## 1. Overview
Performance monitoring and tuning in Google Cloud involves collecting **key metrics**, setting up **alerting strategies**, and defining **Service Level Objectives (SLOs) & Service Level Indicators (SLIs)** to ensure optimal system performance. This document covers monitoring best practices for **GKE (Kubernetes), Compute Engine, and alerting methodologies**.

---

## 2. GKE Metrics
Google Kubernetes Engine (GKE) provides **container-level, node-level, and cluster-level metrics** for monitoring application and infrastructure health.

### **Key GKE Metrics**
| **Metric Category**  | **Example Metrics** |
|---------------------|-------------------|
| **CPU Usage** | `container/cpu/usage_time` |
| **Memory Usage** | `container/memory/usage_bytes` |
| **Pod Availability** | `kubernetes.io/pod/uptime` |
| **Network Traffic** | `kubernetes.io/network/received_bytes_count` |
| **Container Restarts** | `kubernetes.io/container/restart_count` |

### **Viewing GKE Metrics in Cloud Monitoring**
```sh
gcloud monitoring metrics list --filter="metric.type:kubernetes.io"
```

### **Setting Up GKE Alert for High CPU Usage**
```sh
gcloud monitoring policies create \
  --notification-channels=my-channel \
  --conditions="metric.type=kubernetes.io/container/cpu/core_usage_time threshold=0.8"
```

---

## 3. Compute Engine Metrics
Compute Engine provides **virtual machine (VM) performance insights**, allowing monitoring of CPU, disk, and network usage.

### **Key Compute Engine Metrics**
| **Metric Category** | **Example Metrics** |
|---------------------|-------------------|
| **CPU Utilization** | `compute.googleapis.com/instance/cpu/utilization` |
| **Disk I/O** | `compute.googleapis.com/instance/disk/write_bytes_count` |
| **Network Traffic** | `compute.googleapis.com/instance/network/sent_bytes_count` |
| **Memory Usage** | `agent.googleapis.com/memory/usage` |

### **Viewing Compute Engine Metrics**
```sh
gcloud monitoring metrics list --filter="metric.type:compute.googleapis.com"
```

### **Setting Up an Alert for High CPU Utilization**
```sh
gcloud monitoring policies create \
  --notification-channels=my-channel \
  --conditions="metric.type=compute.googleapis.com/instance/cpu/utilization threshold=0.9"
```

---

## 4. Alerting Strategies
Alerting ensures **proactive monitoring and response** to performance issues.

### **Best Practices for Alerts**
✅ Define **clear alert thresholds** based on historical data.  
✅ Use **multi-condition alerts** to prevent false positives.  
✅ Implement **cool-down periods** before triggering alerts.  
✅ Send alerts to **relevant teams via Cloud Monitoring notification channels**.  

### **Example: Creating a Notification Channel for Alerts**
```sh
gcloud monitoring channels create \
  --type=email \
  --display-name="Ops Team Alerts" \
  --email-address=ops-team@example.com
```

---

## 5. SLOs & SLIs
### **1. Service Level Indicators (SLIs)**
SLIs are **quantifiable metrics** that measure system reliability and performance.
- **Example SLIs:**
  - Request latency (`compute.googleapis.com/http/server/response_latencies`)
  - Uptime percentage (`uptime_check/time_since_last_test`
  - Error rate (`logging.googleapis.com/user/error_count`)

### **2. Service Level Objectives (SLOs)**
SLOs define **target performance thresholds** based on SLIs.
- **Example SLOs:**
  - **API Latency:** 95% of requests complete in <200ms.
  - **Uptime:** 99.9% availability per month.
  - **Error Rate:** Less than 0.5% over 24 hours.

### **Creating an SLO in Cloud Monitoring**
```sh
gcloud monitoring slo create \
  --service=my-service \
  --goal=99.9 \
  --rolling-window=30d
```

---

## 6. Final Checklist
✅ Monitor **GKE and Compute Engine metrics** for performance insights.  
✅ Set up **alerts for CPU, memory, and network anomalies**.  
✅ Define **SLIs & SLOs** to measure system reliability.  
✅ Implement **notification channels** to ensure rapid response.  
✅ Regularly **review and adjust alert thresholds** based on system trends.  

📌 **More Resources:** [Google Cloud Monitoring Documentation](https://cloud.google.com/monitoring/docs/)

