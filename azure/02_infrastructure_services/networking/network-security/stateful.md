
## **STATEFULNESS**

### **Azure Firewall**
- **Stateful firewall** meaning it tracks and remembers active connections.
- Inspects packets as part of an ongoing connection and **automatically allows return traffic** without requiring an explicit rule.

#### **Example:**
If a VM initiates an **outbound HTTP request (port 80)** to a web server, Azure Firewall automatically allows the response traffic from the web server back to the VM, even if there is no explicit inbound rule.

---

### **Network Security Group (NSG)**
- Tracks outbound traffic and **automatically allows return traffic**.

#### **Example:**
If NSG allows outbound traffic on **port 443 (HTTPS)**, the response traffic from the destination is automatically allowed.
