**Azure Networking Architecture and Services Summary**

## **Network Architecture Solution Based on Workload Requirements**

Azure provides various networking services to support different workload requirements. When designing a network architecture for an organization migrating workloads to Azure, the following factors should be considered:

- **Naming and Regions:** Define a consistent naming convention and choose Azure regions based on resource consumers.
- **IP Addressing:** Plan private IP address ranges, ensuring no overlap with on-premises networks.
- **Segmentation:** Use subnets based on application layers to isolate workloads.
- **Security Filtering:** Implement network security groups (NSGs) and Azure Firewall for traffic control.
- **Traffic Routing:** Use custom routes to control Azure system routing behavior.

### **Best Practices**
1. **IP Addressing:** Avoid assigning overly large address spaces (/16 recommended) to conserve IP addresses.
2. **Hub-Spoke Network Topology:** Use a central hub virtual network for shared services while keeping workloads in isolated spoke networks.
3. **Virtual Network Peering:** Enable communication between virtual networks while maintaining segmentation and security.

---

## **Azure Network Connectivity Services Patterns**
Azure networking patterns provide various isolation and connectivity approaches:

### **Pattern 1: Single Virtual Network**
- A single virtual network containing multiple subnets.
- Segmentation is achieved using NSGs and Application Security Groups.
- Best for simple environments within a single region.

### **Pattern 2: Multiple Virtual Networks with Peering**
- Extends single virtual network pattern for multi-region deployments.
- Virtual network peering allows explicit connections between networks.
- NSGs provide additional segmentation.

### **Pattern 3: Hub-Spoke Topology**
- A central hub network connects to multiple spoke networks.
- Improves security by funneling all traffic through the hub.
- Azure Firewall in the hub enables better traffic control.
- Best for large organizations needing centralized control.

### **Segmentation and Security**
- **Azure Firewall:** Governs traffic across subnets, virtual networks, and subscriptions.
- **Network Security Groups (NSGs):** Used to control inbound and outbound traffic at subnet or NIC levels.
- **Application Security Groups (ASGs):** Simplify security rule administration.

---

## **Outbound Connectivity and Routing**
Outbound network connectivity and routing in Azure rely on various services:

### **Routing Tables and Route Types**
- **System Routes:** Automatically created when a virtual network is deployed.
- **User-Defined Routes (UDRs):** Custom routes overriding system defaults.
- **Service Endpoint Routes:** Allow direct traffic flow to Azure PaaS services.
- **BGP Routes:** Routes exchanged between on-premises and Azure networks.

### **Routing Considerations**
- **Define System Routes:** For essential traffic flow that shouldn’t change.
- **User-Defined Routes (UDRs):** To override system defaults for customized routing.
- **Forced Tunneling:** Direct all outbound traffic through an NVA or Azure VPN Gateway.

---

## **On-Premises Connectivity to Azure Virtual Network**
Several services support hybrid-cloud connectivity:

### **Azure VPN Gateway**
- **Type:** Encrypted traffic over the public internet.
- **Use Case:** Light traffic hybrid apps where latency isn’t a major concern.
- **Limitations:** Requires on-premises VPN device.

### **Azure ExpressRoute**
- **Type:** Private, dedicated connection through a third-party provider.
- **Use Case:** Large-scale, mission-critical workloads requiring high bandwidth.
- **Limitations:** Higher setup complexity and costs.

### **ExpressRoute with VPN Failover**
- **Type:** Combines ExpressRoute and VPN Gateway as a backup.
- **Use Case:** Requires high availability and fallback connectivity.
- **Limitations:** More complex setup with additional redundancy costs.

### **Azure Virtual WAN and Hub-Spoke Networks**
- **Type:** Microsoft-managed service replacing hub-spoke networks.
- **Use Case:** Large enterprises needing branch-to-Azure and branch-to-branch connectivity.
- **Advantages:** Centralized security with Azure Firewall and seamless scalability.

---

## **Application Delivery Services**
Azure provides multiple load-balancing and traffic distribution services:

### **Azure Front Door**
- Global HTTP(S) load balancer optimizing web traffic routing.
- **Use Case:** Low latency, global failover, CDN integration.

### **Azure Traffic Manager**
- DNS-based load balancer distributing traffic across Azure regions.
- **Use Case:** Performance-based routing, geographic distribution.

### **Azure Load Balancer**
- Layer 4 load balancer handling TCP and UDP traffic.
- **Use Case:** Inbound/outbound traffic management, high-availability setup.

### **Azure Application Gateway**
- Layer 7 load balancer offering path-based and multi-site routing.
- **Use Case:** Web applications needing WAF and session persistence.

---

## **Application Protection Services**
Security services to protect Azure resources:

### **Azure DDoS Protection**
- Defends against volumetric, protocol, and application-layer attacks.
- **Use Case:** Always-on monitoring and attack mitigation.

### **Azure Private Link**
- Private connectivity to Azure PaaS services without internet exposure.
- **Use Case:** Secure access to Azure SQL, Storage, and other PaaS services.

### **Azure Firewall**
- Managed, stateful firewall for inbound and outbound traffic control.
- **Use Case:** Enforcing connectivity policies across subscriptions and VNets.

### **Azure Web Application Firewall (WAF)**
- Protects against common web exploits (SQL injection, XSS).
- **Use Case:** Securing HTTP(S) traffic for web applications.

### **Azure Virtual Network Security Groups (NSGs)**
- Controls traffic flow at subnet and NIC levels.
- **Use Case:** Filtering traffic based on rules and IP restrictions.

### **Azure Virtual Network Service Endpoints**
- Direct access to Azure services over a private connection.
- **Use Case:** Secure and optimized access to Azure resources.
