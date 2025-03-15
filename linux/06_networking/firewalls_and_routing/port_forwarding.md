
## **Port Forwarding**
Port forwarding redirects traffic from one port or host to another.

### **Forward Incoming Traffic on Port 8080 to Internal Server (192.168.1.100:80)**
```bash
sudo iptables -t nat -A PREROUTING -p tcp --dport 8080 -j DNAT --to-destination 192.168.1.100:80
```

### **Forward Ports Using `firewalld`**
```bash
sudo firewall-cmd --add-forward-port=port=8080:proto=tcp:toport=80:toaddr=192.168.1.100 --permanent
sudo firewall-cmd --reload
```

---
