/ip firewall address-list add list="bl_telnet" comment="Black List Telnet"

/ip firewall filter
add action=drop chain=input comment="Drop ip from Block List (Telnet)." \
    in-interface=bridge_lan log=yes log-prefix=bl_telnet src-address-list=\
    bl_telnet
    
add action=jump chain=input comment="Jump to Block List (Telnet)." dst-port=\
    23 in-interface=bridge_lan jump-target=bl_telnet_chain protocol=tcp
    
add action=add-src-to-address-list address-list=bl_telnet \
    address-list-timeout=4w2d chain=bl_telnet_chain comment=\
    "Transfer repeated attempts from bl_telnet_s3 to bl_telnet." \
    connection-state=new src-address-list=\
    bl_telnet_stage3
    
add action=add-src-to-address-list address-list=bl_telnet_stage3 \
    address-list-timeout=1m chain=bl_telnet_chain comment=\
    "Add successive attempts from bl_telnet_s2 to bl_telnet_s3." \
    connection-state=new src-address-list=\
    bl_telnet_stage2
    
add action=add-src-to-address-list address-list=bl_telnet_stage2 \
    address-list-timeout=1m chain=bl_telnet_chain comment=\
    "Add successive attempts from bl_telnet_s1 to bl_telnet_s2." \
    connection-state=new src-address-list=\
    bl_telnet_stage1
    
add action=add-src-to-address-list address-list=bl_telnet_stage1 \
    address-list-timeout=1m chain=bl_telnet_chain comment=\
    "Add initial attempt to bl_telnet_s1." connection-state=new
    
add action=return chain=bl_telnet_chain comment=\
    "Return From bl_telnet_chain."
