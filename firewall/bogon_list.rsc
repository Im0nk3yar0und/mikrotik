/ip firewall filter
add action=drop chain=forward comment="Drop to bogon list" dst-address-list=Bogons

/ip firewall address-list
add address=0.0.0.0/8 comment="Self-Identification [RFC 3330]" disabled=no list=bogons
add address=10.0.0.0/8 comment="Private[RFC 1918] - CLASS A # Check if you need this subnet before enable it" disabled=yes list=bogons
add address=127.0.0.0/8 comment="Loopback [RFC 3330]" disabled=no list=bogons
add address=169.254.0.0/16 comment="Link Local [RFC 3330]" disabled=no list=bogons
add address=172.16.0.0/12 comment="Private[RFC 1918] - CLASS B # Check if you need this subnet before enable it" disabled=yes list=bogons
add address=192.168.0.0/16 comment="Private[RFC 1918] - CLASS C # Check if you need this subnet before enable it" disabled=yes list=bogons
add address=192.0.2.0/24 comment="Reserved - IANA - TestNet1" disabled=no list=bogons
add address=192.88.99.0/24 comment="6to4 Relay Anycast [RFC 3068]" disabled=no list=bogons
add address=198.18.0.0/15 comment="NIDB Testing" disabled=no list=bogons
add address=198.51.100.0/24 comment="Reserved - IANA - TestNet2" disabled=no list=bogons
add address=203.0.113.0/24 comment="Reserved - IANA - TestNet3" disabled=no list=bogons
add address=224.0.0.0/4 comment="MC, Class D, IANA # Check if you need this subnet before enable it" disabled=yes list=bogons
