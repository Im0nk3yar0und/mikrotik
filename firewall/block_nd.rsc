
/ip firewall filter
add action=drop chain=input comment="## Block discovery mikrotik" \
    connection-state=new dst-port=5678,20561 in-interface=bridge_lan log=yes \
    log-prefix=mtk_nd protocol=udp src-address-list=bl_mtk_nd \
    src-mac-address=!AA:BB:CC:DD:EE:FF
    
add action=add-src-to-address-list address-list=bl_mtk_nd \
    address-list-timeout=4w2d chain=input comment=\
    "Add initial attempt to \"Black List mtk_nd\"" connection-state=new \
    dst-port=5678,20561 in-interface=bridge_lan protocol=udp src-mac-address=\
    !AA:BB:CC:DD:EE:FF


add action=drop chain=forward comment="## Block discovery mikrotik" \
    connection-state=new dst-port=5678,20561 in-interface=bridge_lan log=yes \
    log-prefix=mtk_nd protocol=udp src-address-list=bl_mtk_nd \
    src-mac-address=!AA:BB:CC:DD:EE:FF
    
add action=add-src-to-address-list address-list=bl_mtk_nd \
    address-list-timeout=4w2d chain=forward comment=\
    "Add initial attempt to \"Black List mtk_nd\"" connection-state=new \
    dst-port=5678,20561 in-interface=bridge_lan protocol=udp src-mac-address=\
    !AA:BB:CC:DD:EE:FF


/ip firewall raw
add action=drop chain=prerouting comment="Drop mtk_nd" dst-port=5678,20561 \
    in-interface=bridge_lan protocol=udp src-address-list=bl_mtk_nd \
    src-mac-address=!AA:BB:CC:DD:EE:FF
