
# traceroute shows the path packets take to reach a destination
# on some systems use 'mtr example.com' for continuous traceroute

traceroute example.com           # trace the route to example.com
traceroute -n 192.168.1.1        # trace the route without resolving hostnames
traceroute -m 15 192.168.1.1     # limit the max number of hops to 15
traceroute -I example.com        # use ICMP instead of UDP
