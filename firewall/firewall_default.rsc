# Allow established connections
/ip firewall filter
add chain=input action=accept connection-state=established,related

# Drop invalid
add chain=input action=drop connection-state=invalid comment="Drop invalid"

# Allow ICMP (Ping) traffic
add chain=input action=accept protocol=icmp

# Drop all incoming connection not coming from LAN
add chain=input action=drop in-interface-list=!LAN comment="Drop all not coming from LAN"

# Allow winbox
add chain=input action=accept protocol=tcp dst-port=8291 comment="Allow Winbox (8291) input"

# Allow DHCP traffic
add chain=input action=accept in-interface-list=LAN protocol=udp dst-port=67,68

# Allow DNS traffic
add chain=input action=accept in-interface-list=LAN protocol=udp dst-port=53

# Drop all other inbound traffic
add chain=input action=drop

# Allow established connections
add chain=forward action=accept connection-state=established,related comment="Accept established,related"

# Drop invalid
add chain=forward action=drop connection-state=invalid comment="Drop invalid"

# drop all from WAN not DSTNATed
add chain=forward action=drop connection-state=new connection-nat-state=!dstnat in-interface-list=WAN comment="Drop all from WAN not DSTNATed"

# Allow HTTP and HTTPS traffic for web services
add chain=forward action=accept protocol=tcp dst-port=80,443

# Drop all other forwarded traffic
add chain=forward action=drop

# Allow established connections to be sent out
add chain=output action=accept connection-state=established,related

# Allow outgoing DNS traffic
add chain=output action=accept protocol=udp dst-port=53

# Allow outgoing DHCP traffic
add chain=output action=accept protocol=udp dst-port=67,68


# Allow Ping (ICMP) replies
add chain=output action=accept protocol=icmp icmp-options=0:0

# Drop all other outbound traffic
add chain=output action=drop
