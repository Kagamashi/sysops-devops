
# tcpdump captures network packets for analysis
sudo apt install tcpdump

# use Wireshark to analyze .pcap files visually

tcpdump -i eth0           # Capture packets on eth0.
tcpdump -n -i eth0        # Capture without resolving hostnames.
tcpdump -c 10 -i eth0     # Capture only 10 packets.
tcpdump -i eth0 port 80   # Capture HTTP traffic on eth0.
tcpdump -w capture.pcap   # Save packets to a file for later analysis.
