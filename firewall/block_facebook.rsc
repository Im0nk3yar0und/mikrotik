# Blocks Facebook traffic by matching the URL pattern using Layer 7 protocol matching
/ip firewall layer7-protocol
add name=facebook regexp="^..+\\.(facebook.com|facebook.net|fbcdn.com|fbsbx.co\

/ip firewall filter
add action=drop chain=input comment=\
    "# Block Facebook With \"Layer-7\"" disabled=no dst-port=443 \
    layer7-protocol=facebook out-interface=ether1 protocol=tcp
   
# Blocks traffic containing "facebook" in the HTTP content
/ip firewall filter
 add action=drop chain=input comment=\
    "# Block Facebook With \"Content\"" content=facebook.com disabled=no \
    dst-port=443 out-interface=ether1 protocol=tcp
    
add action=drop chain=input content=.facebook. disabled=no \
    dst-port=443 out-interface=ether1 protocol=tcp



# Blocks traffic to "*.facebook.com" based on the TLS host header
/ip firewall filter
add action=drop chain=input comment=\
    "# Block facebook with tls-header" disabled=no dst-port=443 \
    out-interface=ether1 protocol=tcp tls-host=*.facebook.com
