/ip firewall address-list
add list="bl_dos" comment="Black List (DoS)"

/ip firewall filter
add action=tarpit chain=input comment="Drop anyone in Black List (DoS)." \
    connection-limit=3,32 protocol=tcp src-address-list=bl_dos \
    src-mac-address=!AA:BB:CC:DD:EE:FF
    
add action=add-src-to-address-list address-list=bl_dos address-list-timeout=\
    4w2d chain=input comment="Add successive attempts to Black List (DoS)" \
    connection-limit=50,32 log=yes log-prefix=mtk_ddos protocol=tcp \
    src-mac-address=!AA:BB:CC:DD:EE:FF

/ip firewall raw
add action=drop chain=prerouting comment="Drop anyone in Black List (DoS)." \
    protocol=tcp src-address-list=bl_dos src-mac-address=!AA:BB:CC:DD:EE:FF
