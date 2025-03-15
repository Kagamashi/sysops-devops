
## **Advanced Routing Scenarios**
Routing determines how packets move through a network.

### **View Current Routing Table**
```bash
ip route show
```

### **Add a Static Route**
```bash
sudo ip route add 192.168.2.0/24 via 192.168.1.1 dev eth0
```

### **Delete a Route**
```bash
sudo ip route del 192.168.2.0/24
```

### **Configure Policy-Based Routing**
Create a new routing table:
```bash
echo "200 customroute" | sudo tee -a /etc/iproute2/rt_tables
```
Add a rule for packets from `192.168.3.0/24` to use the new route:
```bash
sudo ip rule add from 192.168.3.0/24 table customroute
sudo ip route add default via 192.168.1.1 dev eth0 table customroute
```

---
