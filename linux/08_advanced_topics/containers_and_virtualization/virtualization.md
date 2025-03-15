
## **Network Bridging for VMs and Containers**

Bridging allows virtual machines and containers to communicate like physical hosts.

### **Create a Network Bridge (Using `nmcli`)**
```bash
sudo nmcli connection add type bridge ifname br0 con-name br0
sudo nmcli connection add type ethernet ifname eth0 master br0
sudo nmcli connection up br0
```

### **Verify Bridge Network**
```bash
ip a show br0
```

### **Assign Bridge Network to KVM Virtual Machines**
```bash
virsh net-list --all
virsh net-start default
virsh net-autostart default
```

---
