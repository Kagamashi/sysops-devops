
# nmap is a powerful network scanning tool used for detecting hosts, open ports, and services
sudo apt install nmap

nmap example.com                # Scan a target for open ports.
nmap -p 22,80,443 example.com   # Scan specific ports.
nmap -sV example.com            # Detect services running on open ports.
nmap -A example.com             # Aggressive scan (OS detection, services, scripts).
