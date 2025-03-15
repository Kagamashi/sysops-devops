
## **Basic Network Daemons (DHCP, DNS, etc.)**

### **DHCP (Dynamic Host Configuration Protocol)**

DHCP dynamically assigns **IP addresses** to hosts on a network.

- **DHCP Client Commands:**
  ```bash
  sudo dhclient eth0   # Request an IP from DHCP server
  sudo dhclient -r eth0  # Release the current IP
  ```
- **DHCP Server Configuration (****`/etc/dhcp/dhcpd.conf`****):**
  ```plaintext
  subnet 192.168.1.0 netmask 255.255.255.0 {
      range 192.168.1.100 192.168.1.200;
      option routers 192.168.1.1;
      option domain-name-servers 8.8.8.8;
  }
  ```
- Restart DHCP server:
  ```bash
  sudo systemctl restart isc-dhcp-server
  ```

### **DNS (Domain Name System)**

DNS translates **domain names to IP addresses**.

- **Checking DNS Resolution:**
  ```bash
  nslookup example.com
  dig example.com
  host example.com
  ```
- **Basic DNS Server Configuration (****`/etc/bind/named.conf.options`**** for BIND DNS Server):**
  ```plaintext
  options {
      forwarders {
          8.8.8.8;
          1.1.1.1;
      };
  };
  ```
- Restart DNS server:
  ```bash
  sudo systemctl restart bind9
  ```

### **HTTP/HTTPS Services**

HTTP(S) servers like Apache and Nginx provide web services.

- **Start a Web Server:**
  ```bash
  sudo systemctl start apache2  # Apache on Debian/Ubuntu
  sudo systemctl start nginx    # Nginx
  ```
- **Check if HTTP is Running:**
  ```bash
  curl -I http://example.com
  ```

### **SSH (Secure Shell)**

SSH allows secure remote administration of servers.

- **Check if SSH is Running:**
  ```bash
  sudo systemctl status ssh
  ```
- **Restart SSH Service:**
  ```bash
  sudo systemctl restart ssh
  ```

---
