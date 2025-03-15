# Azure Monitoring & Observability

## Introduction to Monitoring
Monitoring is essential for tracking the state, health, and performance of IT environments, ensuring applications run optimally, securely, and reliably.

### Key Activities:
- **Data Collection**: Metrics, logs, and traces for insights.
- **Data Analysis**: Identifying patterns, anomalies, and trends.
- **Alerts**: Trigger notifications for predefined conditions.
- **Visualizations**: Graphical representations for better insights.
- **Diagnostics & Troubleshooting**: Root cause analysis for issues.

### Benefits:
- Performance optimization and cost efficiency.
- Proactive management to prevent issues.
- Enhanced reliability and security monitoring.
- Capacity planning for infrastructure scalability.
- Compliance and governance adherence.

---
## Overview of Azure Monitor
Azure Monitor provides tools for collecting, managing, and analyzing data from Azure, other clouds, and on-premises environments.

### **Key Features:**
- **Data Collection & Storage**: Automatically collects data when resources are added.
- **Data Analysis & Response**: Provides query tools like Kusto Query Language (KQL).
- **Alerts & Workbooks**: Sends notifications or automates responses.
- **Visualizations**: Dashboards, reports, and real-time analytics.

---
## Metrics & Logs
### **Metrics:**
- Quantitative performance indicators (CPU usage, response times, etc.).
- Used for real-time monitoring and triggering alerts.
- Supports **Azure platform metrics**, **custom metrics**, and **Prometheus metrics**.

### **Logs:**
- Textual event records providing contextual insights.
- Used for debugging, tracing, and auditing.
- Stored in **Log Analytics workspace** for queries and analysis.

---
## Insights & Observability
### **Azure Monitor Insights:**
Provides specialized monitoring experiences:
- **Application Insights**: Tracks application performance, logs, and telemetry.
- **Container Insights**: Monitors Azure Kubernetes Service (AKS) and containers.
- **VM Insights**: Analyzes performance and dependencies for Azure VMs.
- **Network Insights**: Visualizes network health and security.

---
## Visualizations & Dashboards
### **Azure Monitor Visualization Tools:**
- **Workbooks**: Interactive reports combining multiple data sources.
- **Dashboards**: Customizable overviews combining metrics, logs, and queries.
- **Power BI**: Advanced analytics and reporting.
- **Grafana**: Open-source dashboarding with multi-cloud integration.

---
## Automated Actions & Response
### **Azure Monitor Alerts:**
- Provides real-time notifications and automated responses.
- Supports metric-based and log-based alerting.
- Integrates with **Action Groups** for automated workflows (email, SMS, webhooks).

### **Autoscale:**
- Dynamically adjusts resources based on monitored metrics.
- Defines rules for scaling up/down workloads to optimize cost and performance.

### **AIOps (Artificial Intelligence for IT Operations):**
- Uses machine learning for automated anomaly detection.
- Predicts capacity usage and identifies performance issues.

# **Azure Monitor Alerts & Action Groups**

## **Introduction to Azure Monitor**
Azure Monitor is a powerful tool for monitoring and analyzing the health, performance, and behavior of your Azure resources. It enables proactive responses to faults and ensures key resources are monitored efficiently.

### **Types of Data in Azure Monitor**
Azure Monitor collects two principal types of data from target resources (applications, OS, subscriptions, tenants):
- **Metrics** – Numerical time-series data representing performance (e.g., CPU usage, disk space).
- **Logs** – Structured records of events and system behaviors, useful for detailed analysis.

---

## **Types of Alerts in Azure Monitor**
Azure Monitor supports different types of alerts to detect and respond to changes in an environment:

### **1. Metric Alerts**
- Triggered when a resource exceeds a predefined **threshold** (e.g., CPU > 90%).
- Used for **real-time performance monitoring**.
- Two types:
  - **Static threshold alerts** – Based on a fixed limit (e.g., CPU > 85% for 10 minutes).
  - **Dynamic threshold alerts** – Uses **machine learning** to adjust thresholds automatically.
- Supports **dimensions** to monitor multiple instances simultaneously.

### **2. Log Alerts**
- Based on queries run against **log data** (e.g., error rates, failed transactions).
- Two result types:
  - **Number of records** – Counts event occurrences (e.g., number of 500 errors).
  - **Metric measurement** – Applies **aggregation** (e.g., average response time).
- Unlike metric alerts, **log alerts are stateless** (each event triggers a new alert).

### **3. Activity Log Alerts**
- Triggered when **Azure resource changes occur** (e.g., VM deletion, role changes).
- Two types:
  - **Specific operations** – Alerts on changes to individual resources (e.g., when a VM is deleted).
  - **Service health events** – Notifies users about **Azure service issues, maintenance, or advisories**.
- These alerts **only apply within the subscription where they are created**.

---

## **Creating and Managing Alerts**
### **Components of an Alert Rule**
Every alert consists of:
1. **Resource** – The monitored Azure service (VM, storage account, etc.).
2. **Condition** – The signal type used (metric, log, activity log).
3. **Actions** – The response when an alert is triggered (email, webhook, automation).
4. **Alert Details** – Name, description, and severity level (0 to 4).

### **Alert Processing Rules**
Alert processing rules **modify** alerts before they are fired:
- Suppress notifications during maintenance windows.
- Apply common logic across multiple alerts.
- Automatically add/remove action groups.

---

## **Action Groups**
When an alert is triggered, **action groups** define what happens next. Azure Monitor supports multiple actions, including:
- **Notifications**: Email, SMS, push notifications, voice calls.
- **Automation**: Triggering an **Azure Function, Logic App, Runbook, or IT Service Management (ITSM) ticket**.
- **Scaling Actions**: Restarting a VM, scaling up/down.

Action groups **can be reused across multiple alerts** (e.g., notify the same operations team for different issues).
