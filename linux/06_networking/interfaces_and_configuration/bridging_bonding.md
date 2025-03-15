
## **Bridging, Bonding, and VLAN Basics**

### **Bridging (Network Interface Aggregation)**
A network bridge allows multiple network interfaces to act as one.

| Command | Description |
|---------|-------------|
| `brctl addbr br0` | Create a new bridge interface. |
| `brctl addif br0 eth0` | Add an interface to the bridge. |
| `ip link set br0 up` | Bring up the bridge interface. |

### **Bonding (Link Aggregation for Redundancy & Performance)**
Bonding combines multiple interfaces to improve **network reliability** and **bandwidth**.

1. Install bonding module:
   ```bash
   sudo modprobe bonding
   ```
2. Configure bonding in `/etc/network/interfaces` (Debian/Ubuntu):
   ```plaintext
   auto bond0
   iface bond0 inet static
       address 192.168.1.100
       netmask 255.255.255.0
       slaves eth0 eth1
       bond-mode 1
       bond-miimon 100
   ```
3. Restart networking:
   ```bash
   sudo systemctl restart networking
   ```

### **VLANs (Virtual Local Area Networks)**
VLANs allow segmentation of network traffic within the same physical network.

| Command | Description |
|---------|-------------|
| `ip link add link eth0 name eth0.10 type vlan id 10` | Create VLAN 10 on `eth0`. |
| `ip link show eth0.10` | Verify VLAN interface. |
| `ip addr add 192.168.10.1/24 dev eth0.10` | Assign IP to VLAN. |

To make VLANs persistent, configure `/etc/network/interfaces` (Debian/Ubuntu):
```plaintext
auto eth0.10
iface eth0.10 inet static
    address 192.168.10.1
    netmask 255.255.255.0
    vlan-raw-device eth0
```

---
