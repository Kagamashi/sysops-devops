
# netstat and ss provide detailed information about network connections

netstat -tuln     # show listening ports TCP and UDP
netstat -rn       # show routing table

ss -tuln      # show listening ports (modern alternative to netstat)
ss -s         # show socket summary
