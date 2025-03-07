/ip firewall mangle
add action=change-ttl chain=output comment="Change TTL" new-ttl=set:255 out-interface=ether1 passthrough=no \
    protocol=!icmp
