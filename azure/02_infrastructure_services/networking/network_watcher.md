# Azure Network Watcher

Azure Network Watcher is a set of tools designed to monitor, diagnose, and analyze the network health of Azure IaaS (Infrastructure-as-a-Service) resources. It helps in troubleshooting network issues related to virtual machines (VMs), virtual networks (VNets), load balancers, application gateways, and VPNs.

Network Watcher is **not** designed for monitoring PaaS services or Web analytics.

## Network Watcher Features
Network Watcher consists of three major tool categories:
1. **Monitoring Tools**
2. **Network Diagnostic Tools**
3. **Traffic Analysis Tools**

---

## 1. Monitoring Tools
### **Topology**
- Provides a **visual representation** of the entire Azure network.
- Helps in understanding resource configurations and their relationships.
- Useful for troubleshooting connectivity and configuration issues.

### **Connection Monitor**
- Offers **end-to-end** monitoring for Azure and hybrid network connections.
- Measures **latency, availability, and packet loss** between endpoints.
- Helps validate communication between multi-tier applications.

---

## 2. Network Diagnostic Tools
Network Watcher includes several tools for diagnosing and troubleshooting network issues:

### **IP Flow Verify**
- Detects traffic filtering issues at the **VM level**.
- Checks whether packets are **allowed or denied** and which NSG rule caused the action.

### **NSG Diagnostics**
- Analyzes **Network Security Groups (NSGs)** at the VM, VM Scale Set, or Application Gateway level.
- Identifies NSG rules responsible for **allowing or denying** traffic.

### **Next Hop**
- Determines the **next hop** for a packet sent from a VM.
- Helps diagnose **incorrect routing** issues.

### **Effective Security Rules**
- Displays **all security rules** applied to a VM’s network interface and subnet.
- Helps in troubleshooting why specific traffic is **allowed or blocked**.

### **Connection Troubleshoot**
- Tests connectivity between Azure resources, such as **VMs, FQDNs, URIs, or IP addresses**.
- Provides **latency and hop details** for connections.

### **Packet Capture**
- Allows **remote packet capture** for VMs.
- Captures network traffic **for analysis and troubleshooting**.

### **VPN Troubleshoot**
- Diagnoses issues with **Azure VPN gateways and connections**.
- Provides a **health diagnosis report** and recommended actions.

---

## 3. Traffic Analysis Tools

### **Flow Logs**
- Logs Azure **IP traffic** and stores the data in **Azure Storage**.
- Can log **network security group (NSG) traffic**.

### **Traffic Analytics**
- Provides **visual insights** into traffic flow logs.
- Helps analyze **traffic patterns, bandwidth utilization, and security risks**.

---

## Network Watcher Deployment
- **Automatically enabled** when a virtual network is created in an Azure region.
- Accessible via the **Azure portal**, **PowerShell**, **Azure CLI**, or **REST API**.

---

## Use Cases
Network Watcher can be used in various scenarios, including:

### **1. Resolving Connectivity Issues for IaaS VMs**
- Use **IP Flow Verify** to determine whether a VM can communicate with another VM.
- Identify **NSG rules blocking traffic**.

### **2. Troubleshooting VPN Connections**
- Use **VPN Troubleshoot** to diagnose VPN connectivity issues.
- Verify the **health of virtual network gateways**.

### **3. Determining Cross-Region Latency**
- Use **Connection Monitor** to test latencies between Azure regions.
- Helps in deciding **optimal VM placement**.
