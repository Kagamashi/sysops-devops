
# Fail2Ban monitors logs and bans IPs that show malicious behavior (e.g. multiple failed login attempts)

# installing and Configuring Fail2Ban:
sudo apt install fail2ban  # Debian-based systems
sudo dnf install fail2ban  # RedHat-based systems

# enable the service:
sudo systemctl enable --now fail2ban

# view ban logs:
sudo fail2ban-client status sshd

# unban an IP:
sudo fail2ban-client set sshd unbanip 192.168.1.100
