
# [dynamic firewall management]
# firewalld provides an easier way to manage firewalls with zones and services

sudo systemctl enable --now firewalld 

sudo firewallc-md --state       # check if firewalld is running
sudo firewall-cmd --list-all    # show active firewall rules

sudo firewall-cmd --add-port=22/tcp --permanent     # Allow SSH.
sudo firewall-cmd --remove-port=80/tcp --permanent  # Block HTTP.
sudo firewall-cmd --permanent --add-service=ssh   # allow SSH permanently
sudo firewall-cmd --permanent --add-service=http  # allow HTTP permanently
sudo firewall-cmd --permanent --add-service=https # allow HTTPS permanently

sudo firewall-cmd --reload                        # reload firewalld to apply changes
