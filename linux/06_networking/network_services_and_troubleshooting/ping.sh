
# ping command verifies network connectivity between a local and remote system using ICMP echo requests

ping example.com              # send ICMP echo requests to example.com
ping -c 4 192.168.1.1         # send 4 pings to a specific IP address
ping -i 0.5 example.com       # ping with a 500ms interval between requests
ping -s 1000 example.com      # send pings with a packet size of 1000 bytes
