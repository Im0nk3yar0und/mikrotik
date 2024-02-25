# Blocks YouTube traffic by matching the URL pattern using Layer 7 protocol matching
/ip firewall layer7-protocol
add name=youtube regexp="^.+(youtube.com).*\$ "

/ip firewall filter
add action=drop chain=input comment=\
    "# Block YouTube With \"Layer-7\"" disabled=no dst-port=443 \
    layer7-protocol=youtube out-interface=ether1 protocol=tcp
   
# Blocks traffic containing "youtube" in the HTTP content
/ip firewall filter
 add action=drop chain=input comment=\
    "# Block YouTube With \"Content\"" content=youtube.com disabled=no \
    dst-port=443 out-interface=ether1 protocol=tcp
    
add action=drop chain=input content=.youtube. disabled=no \
    dst-port=443 out-interface=ether1 protocol=tcp



# Blocks traffic to "*.youtube.com" based on the TLS host header
/ip firewall filter
add action=drop chain=input comment=\
    "# Block youtube with tls-header" disabled=no dst-port=443 \
    out-interface=ether1 protocol=tcp tls-host=*.youtube.com
