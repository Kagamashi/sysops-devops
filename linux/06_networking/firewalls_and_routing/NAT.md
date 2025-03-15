
## **NAT (Network Address Translation)**
NAT allows private IP addresses to be translated to public IPs for internet access.

### **Enable IP Forwarding for NAT**
```bash
echo 1 | sudo tee /proc/sys/net/ipv4/ip_forward
sudo sysctl -w net.ipv4.ip_forward=1
```
To make it persistent, add this line to `/etc/sysctl.conf`:
```plaintext
net.ipv4.ip_forward = 1
```

### **Masquerading with `iptables`**
```bash
sudo iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE
```

---
