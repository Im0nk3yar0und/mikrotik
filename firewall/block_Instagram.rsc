# Blocks Instagram traffic by matching the URL pattern using Layer 7 protocol matching
/ip firewall layer7-protocol
add name=Instagram regexp="^.+(instagram.com).*\$"

/ip firewall filter
add action=drop chain=input comment=\
    "# Block Instagram With \"Layer-7\"" disabled=no dst-port=443 \
    layer7-protocol=Instagram out-interface=ether1 protocol=tcp
   
# Blocks traffic containing "instagram" in the HTTP content
/ip firewall filter
 add action=drop chain=input comment=\
    "# Block Instagram With \"Content\"" content=instagram.com disabled=no \
    dst-port=443 out-interface=ether1 protocol=tcp
    
add action=drop chain=input content=.instagram. disabled=no \
    dst-port=443 out-interface=ether1 protocol=tcp

# Blocks traffic to "*.instagram.com" based on the TLS host header
/ip firewall filter
add action=drop chain=input comment=\
    "# Block instagram with tls-header" disabled=no dst-port=443 \
    out-interface=ether1 protocol=tcp tls-host=*.instagram.com
