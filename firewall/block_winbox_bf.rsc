/ip firewall address-list 
add list="bl_winbox" comment="Black List (Winbox)"
add address=10.0.0.0/24 list="Allow WinBox safe hosts"

#Winbox Brute Force Protection Rules
/ip firewall filter

add action=drop chain=input comment="Drop (WinBox) brute forcers" log=yes \
    log-prefix=winbox_block src-address-list="bl_winbox" \
    src-mac-address=!AA:BB:CC:DD:EE:FF

#Allow WinBox login from safe hosts
add action=accept chain=input comment="Allow (WinBox) safe hosts" \
    connection-state=new dst-port=8291 in-interface-list=LAN protocol=tcp \
    src-address-list="Allow WinBox safe hosts"
    
add action=jump chain=input comment="Jump to Black List (Winbox) chain." \
    dst-port=8291 jump-target="bl_winbox_chain" protocol=tcp
    
add action=add-src-to-address-list address-list="bl_winbox" \
    address-list-timeout=4w2d chain="bl_winbox_chain" comment="Trans\
    fer repeated attempts from Black List (Winbox) Stage 3 to Black List (Winb\
    ox)." connection-state=new src-address-list="bl_winbox_stage3"
    
add action=add-src-to-address-list address-list="bl_winbox_stage3" \
    address-list-timeout=1m chain="bl_winbox_chain" comment=\
    "Add succesive attempts to Black List (Winbox) Stage 3." \
    connection-state=new src-address-list="bl_winbox_stage2"
    
add action=add-src-to-address-list address-list="bl_winbox_stage2" \
    address-list-timeout=1m chain="bl_winbox_chain" comment=\
    "Add succesive attempts to Black List (Winbox) Stage 2." \
    connection-state=new src-address-list="bl_winbox_stage1"
    
add action=add-src-to-address-list address-list="bl_winbox_stage1" \
    address-list-timeout=1m chain="bl_winbox_chain" comment=\
    "Add initial attempt to Black List (Winbox) Stage 1." connection-state=new
    
add action=return chain="bl_winbox_chain" comment="Return From Black List (Winbox) chain."

/ip firewall raw
add action=drop chain=prerouting comment="Drop WinBox brute forcers" \
    in-interface-list=LAN src-address-list="bl_winbox"
