# Allow DNS traffic
/ip firewall filter
add chain=input action=accept in-interface-list=bridge_lan protocol=udp dst-port=53
add chain=output action=accept protocol=udp dst-port=53

# Force users to use MikroTik DNS - 10.0.0.1
/ip firewall nat
add action=dst-nat chain=dstnat comment="Force users to use MikroTik DNS" \
    dst-address=!10.0.0.1 dst-port=53 in-interface=bridge_lan protocol=\
    udp to-addresses=10.0.0.1 to-ports=53

/ip dns
set allow-remote-requests=yes
