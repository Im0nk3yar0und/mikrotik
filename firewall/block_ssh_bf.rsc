#SSH Brute Force Protection Rules
/ip firewall address-list
add list="bl_ssh" comment="Black List (SSH)"

/ip firewall filter
add action=drop chain=input comment="Drop anyone in Black List (SSH)." log=\
    yes log-prefix=bl_ssh src-address-list=bl_ssh src-mac-address=\
    !AA:BB:CC:DD:EE:FF
    
add action=jump chain=input comment="Jump to Black List (SSH) chain." \
    in-interface=bridge_lan dst-port=22 jump-target=bl_ssh_chain protocol=tcp
    
add action=add-src-to-address-list address-list=bl_ssh address-list-timeout=\
    4w2d chain=bl_ssh_chain comment="Transfer repeated attempts from Black Lis\
    t (SSH) Stage 3 to Black List (SSH)." connection-state=new \
    src-address-list=bl_ssh_stage3
    
add action=add-src-to-address-list address-list=bl_ssh_stage3 \
    address-list-timeout=1m chain=bl_ssh_chain comment=\
    "Add successive attempts to Black List (SSH) Stage 3." connection-state=\
    new src-address-list=bl_ssh_stage2
    
add action=add-src-to-address-list address-list=bl_ssh_stage2 \
    address-list-timeout=1m chain=bl_ssh_chain comment=\
    "Add successive attempts to Black List (SSH) Stage 2." connection-state=\
    new src-address-list=bl_ssh_stage1
    
add action=add-src-to-address-list address-list=bl_ssh_stage1 \
    address-list-timeout=1m chain=bl_ssh_chain comment=\
    "Add initial attempt to Black List (SSH) Stage 1." connection-state=new
    
add action=return chain=bl_ssh_chain comment=\
    "Return From Black List (SSH) chain."

/ip firewall raw
add action=drop chain=prerouting comment="Drop SSH brute forcers" \
    in-interface-list=LAN src-address-list=bl_ssh
