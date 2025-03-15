
# [modern firewall framework]
# nftables replaces iptables and offers better performance and flexibility

sudo nft list ruleset             # list all rules in the nftables ruleset
sudo nft list tables              # list all firewall tables
sudo nft add table inet filter    # create a firewall table

sudo nft add chain inet filter input { type filter hook input priority 0 }  # create an input chain

sudo nft add rule inet filter input tcp dport 22 accept  # allow SSH on port 22
sudo nft add rule inet filter input tcp dport 80 accept  # allow HTTP on port 80
sudo nft add rule inet filter input tcp dport 443 accept # allow HTTPS on port 443
sudo nft add rule inet filter input drop                 # block all other connections
