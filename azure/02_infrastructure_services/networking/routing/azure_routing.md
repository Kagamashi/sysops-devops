# Azure Routing and Network Virtual Appliances (NVAs)

## 1. Overview of Azure Routing
Azure automatically routes network traffic between subnets, virtual networks, and on-premises networks using system routes. Each subnet in an Azure virtual network has default system routes.

### **System Routes**
| Address Prefix | Next Hop Type |
|---------------|--------------|
| Unique to the virtual network | Virtual network |
| 0.0.0.0/0 | Internet |
| 10.0.0.0/8 | None |
| 172.16.0.0/12 | None |
| 192.168.0.0/16 | None |
| 100.64.0.0/10 | None |

- **Virtual network:** Routes traffic within the VNet.
- **Internet:** Default route for external traffic.
- **None:** Traffic to these private address spaces is dropped by default.

### **Additional System Routes**
Azure also creates additional system routes for:
- **Virtual network peering**
- **Service chaining**
- **Virtual network gateway**
- **Virtual network service endpoint**

---

## 2. Custom Routing in Azure
You can override system routes by defining **custom routes** to control traffic flow. This is useful for implementing firewalls or directing traffic through specific network appliances.

### **Custom Routing Methods**
1. **User-defined routes**
2. **Border Gateway Protocol (BGP)**

### **User-Defined Routes**
Allows traffic to be routed through:
- **Virtual appliances** (firewalls, security appliances)
- **Virtual network gateway** (VPN)
- **Custom next-hop destinations**
- **Internet**

### **Service Tags in Routing**
Azure service tags simplify routing configuration by representing groups of IP addresses for Azure services. Microsoft manages these tags, reducing manual updates.

---

## 3. Border Gateway Protocol (BGP)
BGP allows Azure VPN gateways to exchange routes with on-premises routers dynamically. It’s used in:
- **ExpressRoute**: Private, high-speed Azure connectivity.
- **Site-to-Site VPNs**: Secure tunnels between on-premises and Azure.
- **Multi-site connections**: Connecting multiple remote locations to Azure.

### **Benefits of BGP**
- **Dynamic Route Updates**: Eliminates manual updates.
- **Network Stability**: Automatically reroutes traffic in case of failures.
- **Scalability**: Allows multiple networks to integrate seamlessly.

---

## 4. Route Selection and Priority
If multiple routes exist for the same address, Azure selects the most specific match.

### **Route Selection Order**
1. **User-defined routes** (highest priority)
2. **BGP routes**
3. **System routes** (default)

Example: If routes for `10.0.0.0/16` and `10.0.0.0/24` exist, Azure selects `10.0.0.0/24` because it is more specific.

---

## 5. Network Virtual Appliances (NVAs)
An **NVA** is a virtual appliance that controls network traffic. It includes:
- **Firewalls**
- **WAN optimizers**
- **Load balancers**
- **IDS/IPS security devices**

### **Common NVA Providers**
- Cisco
- Check Point
- Barracuda
- Sophos
- SonicWall

### **Using NVAs for Network Security**
- Filter inbound traffic.
- Block malicious requests.
- Monitor and log network activity.
- Secure both virtual-machine and Azure-service networking.

---

## 6. Implementing NVAs with User-Defined Routes
### **Example Scenario**
A retail company wants to:
- Inspect all traffic using a firewall.
- Block unauthorized traffic from reaching internal networks.
- Secure both VM and Azure-service networking.

### **Solution: Microsegmentation Approach**
1. **Deploy an NVA in a separate subnet.**
2. **Create user-defined routes (UDRs) to force traffic through the NVA.**
3. **Enable packet inspection at OSI Layer 4 (and Layer 7 if supported).**
4. **Configure forwarding rules to direct traffic to the correct destinations.**

### **Ensuring High Availability for NVAs**
To prevent failures:
- Deploy NVAs in **redundant pairs**.
- Use an **Azure Load Balancer** to distribute traffic.
- Implement **automatic failover mechanisms**.

---

## Summary
- **Azure uses system routes by default but allows custom routing.**
- **User-defined routes** override system routes for security and compliance.
- **BGP enables dynamic route exchange between Azure and on-premises networks.**
- **NVAs provide an additional security layer for traffic filtering and monitoring.**
- **High availability techniques ensure reliable NVA deployments.**

By leveraging **Azure routing and NVAs**, organizations can achieve secure, scalable, and efficient network configurations.

