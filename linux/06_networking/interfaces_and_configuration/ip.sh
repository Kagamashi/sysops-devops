
# ip command replaces older tools like ifconfig for managing network interfaces

ip a                                   # show all network interfaces and IP addresses
ip link show                           # display interface details (status, MAC, address)
ip route show                          # display current routing table
ip addr add 192.168.1.10/24 dev eth0   # assign an IP address to an interface
ip link set eth0 up                    # enable an interface
ip link set eth0 down                  # disable an interface


## IPv4 and IPv6 Addresses
ip addr show                 # display network interface addresses (IPv4/IPv6)
ip -4 addr show              # display only IPv4 addresses
ip -6 addr show              # display only IPv6 addresses

ip addr add 192.168.1.100/24 dev eth0   # add an IPv4 address to an interface
ip addr add 2001:db8::1/64 dev eth0     # add an IPv6 address to an interface

ip addr del 192.168.1.100/24 dev eth0   # remove an IPv4 address from an interface
ip addr del 2001:db8::1/64 dev eth0     # remove an IPv6 address from an interface


## Network Masks, Gateways, DNS
ip route add default via 192.168.1.1    # add a default gateway (IPv4)
ip -6 route add default via 2001:db8::1 # add a default gateway (IPv6)


## Routing
ip route add 192.168.2.0/24 via 192.168.1.1    # add static route for a subnet
ip route del 192.168.2.0/24 via 192.168.1.1    # remove a static route
