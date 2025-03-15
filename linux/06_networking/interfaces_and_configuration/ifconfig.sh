
# [legacy]
# ifconfig is older but still found on some systems
# ip should be used where possible instead

ifconfig              # show all network interfaces and their configurations
ifconfig eth0 up      # enable an interface
ifconfig eth0 down    # disable an interface
ifconfig eth0 192.168.1.10 netmask 255.255.255.0  # assign an IP address to eth0
