
# [legacy firewall management]
# iptables is a rule-based firewall used for packet filtering

sudo iptables -L -v                                 # list firewall rules (IPv4)
iptables -F                                         # flush all rules (use with caution)

sudo iptables -A INPUT -p tcp --dport 22 -j ACCEPT  # allow SSH on port 22
sudo iptables -A INPUT -p tcp --dport 80 -j DROP    # block HTTP on port 80
sudo iptables -A INPUT -p tcp --dport 443 -j ACCEPT # allow HTTPS on port 443
sudo iptables -A INPUT -j DROP                      # block all other connections

sudo iptables-save                  # save the firewall rules
sudo iptables-save > rules.v4
sudo iptables-restore < rules.v4    # restore firewall rules
