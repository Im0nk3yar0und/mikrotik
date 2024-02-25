# Accept Knocked Connections
/ip firewall filter
add action=accept chain=ssh_portKnocking comment=KnockedSuccessfully \
    connection-state=new dst-port=457 log=yes log-prefix=ssh_login protocol=\
    tcp src-address-list=pk_sshAllow


# SSH Port Knocking Rule & Port Knocking Sequence
/ip firewall filter
add action=jump chain=input comment="SSH Port Knocking" dst-port=\
    9835,6738,6845,10685,475 in-interface=bridge_lan jump-target=\
    ssh_portKnocking protocol=tcp src-mac-address=AA:BB:CC:EE:DD:FF

add action=add-src-to-address-list address-list=pk_sshAllow \
    address-list-timeout=20s chain=ssh_portKnocking comment=\
    "#KnockKnock:9835" connection-state=new dst-port=9835 protocol=tcp \
    src-address-list=pk_stage3
    
add action=add-src-to-address-list address-list=pk_stage3 \
    address-list-timeout=5s chain=ssh_portKnocking comment="#KnockKnock:6738" \
    connection-state=new dst-port=6738 protocol=tcp src-address-list=\
    pk_stage2
    
add action=add-src-to-address-list address-list=pk_stage2 \
    address-list-timeout=5s chain=ssh_portKnocking comment="#KnockKnock:6845" \
    connection-state=new dst-port=6845 protocol=tcp src-address-list=\
    pk_stage1
    
add action=add-src-to-address-list address-list=pk_stage1 \
    address-list-timeout=5s chain=ssh_portKnocking comment=\
    "#KnockKnock:10685" connection-state=new dst-port=10685 protocol=tcp

add action=return chain=ssh_portKnocking comment=\
    "Return from SSH Port Knocking"










