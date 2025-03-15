# Linux systems use various firewall tools to control network traffic.

# Best practices:
#   - Allow Only Necessary Ports (e.g., 22 for SSH, 443 for HTTPS)
#   - Use UFW/firewalld for simplicity or iptables/nftables for advanced control
#   - Enable logging to detect unauthorized access attempts
#   - Combine firewall rules with Fail2Ban for automatic banning of malicious IPs.

# UFW (Uncomplicated Firewall) – Debian/Ubuntu
sudo ufw enable           # Enable firewall
sudo ufw allow 22/tcp     # Allow SSH (port 22)
sudo ufw deny 80/tcp      # Deny HTTP (port 80)
sudo ufw status numbered  # List firewall rules
sudo ufw delete 1         # Remove rule #1

# firewalld – RedHat/Fedora/CentOS
sudo systemctl enable --now firewalld  # Start firewall service
sudo firewall-cmd --add-port=22/tcp --permanent  # Allow SSH
sudo firewall-cmd --reload  # Apply changes
sudo firewall-cmd --list-all  # List firewall rules

# iptables – Low-Level Firewall Tool
sudo iptables -A INPUT -p tcp --dport 22 -j ACCEPT  # Allow SSH
sudo iptables -A INPUT -p tcp --dport 80 -j DROP    # Block HTTP
sudo iptables -L -v  # View current rules

# nftables – Modern Replacement for iptables
sudo nft add table inet filter
sudo nft add chain inet filter input { type filter hook input priority 0; }
sudo nft add rule inet filter input tcp dport 22 accept  # Allow SSH
sudo nft add rule inet filter input tcp dport 80 drop    # Block HTTP
sudo nft list ruleset  # Show rules
