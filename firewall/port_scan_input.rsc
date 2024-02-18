/ip firewall address-list
add comment="Black List (Port Scan)" list=bl_portScan

/ip firewall filter
add action=drop chain=input comment="Drop anyone in the Port Scanner (input)" \
    src-address-list=bl_portScan src-mac-address=!AA:BB:CC:DD:EE:FF
    
add action=jump chain=input comment="Jump to Port SCAN chain." jump-target=\
    port_scan_in protocol=tcp
    
add action=add-src-to-address-list address-list=bl_portScan \
    address-list-timeout=4w2d chain=port_scan_in comment=\
    "Port scanners to list " log=yes log-prefix=port_scan_in protocol=tcp \
    psd=21,3s,3,1
    
add action=add-src-to-address-list address-list=bl_portScan \
    address-list-timeout=4w2d chain=port_scan_in comment=\
    "NMAP FIN Stealth scan" log=yes log-prefix=port_scan_in protocol=tcp \
    tcp-flags=fin,!syn,!rst,!psh,!ack,!urg
    
add action=add-src-to-address-list address-list=bl_portScan \
    address-list-timeout=4w2d chain=port_scan_in comment="NMAP NULL scan" \
    log=yes log-prefix=port_scan_in protocol=tcp tcp-flags=\
    !fin,!syn,!rst,!psh,!ack,!urg
    
add action=add-src-to-address-list address-list=bl_portScan \
    address-list-timeout=4w2d chain=port_scan_in comment="SYN/FIN scan" log=\
    yes log-prefix=port_scan_in protocol=tcp tcp-flags=fin,syn
    
add action=add-src-to-address-list address-list=bl_portScan \
    address-list-timeout=4w2d chain=port_scan_in comment="SYN/RST scan" log=\
    yes log-prefix=port_scan_in protocol=tcp tcp-flags=syn,rst
    
add action=add-src-to-address-list address-list=bl_portScan \
    address-list-timeout=4w2d chain=port_scan_in comment="FIN/PSH/URG scan" \
    log=yes log-prefix=port_scan_in protocol=tcp tcp-flags=\
    fin,psh,urg,!syn,!rst,!ack
    
add action=add-src-to-address-list address-list=bl_portScan \
    address-list-timeout=4w2d chain=port_scan_in comment="ALL/ALL scan" log=\
    yes log-prefix=port_scan_in protocol=tcp tcp-flags=\
    fin,syn,rst,psh,ack,urg
    
add action=return chain=port_scan_in comment="Return from Port Scan rule"


/ip firewall raw
add action=drop chain=prerouting comment=Drop_port_scanner_addr \
    in-interface-list=LAN src-address-list=bl_portScan
